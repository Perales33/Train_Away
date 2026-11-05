import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

import 'pages/confirmation_dialog.dart';
import 'pages/date_time_page.dart';
import 'pages/form_page.dart';
import 'pages/reservation_confirmed.dart';
import 'pages/success_page.dart';
import 'theme/app_colors.dart';
import 'widgets/app_bottom_button.dart';
import 'widgets/app_banner.dart';

void main() => runApp(const TrainAwayApp());

class TrainAwayApp extends StatelessWidget {
  const TrainAwayApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Train Away',
        debugShowCheckedModeBanner: false,
        supportedLocales: const [Locale('en'), Locale('es')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          SfGlobalLocalizations.delegate,
        ],
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.navy, primary: AppColors.navy),
          fontFamily: 'DM Sans',
        ),
        home: const ConfirmationPage(),
      );
}

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({super.key});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  bool _showReservationSummary = false;
  bool _success = false;
  String _origin = 'Estación Norte de Madrid';
  String _destination = 'Estación Sur de Barcelona';
  int _passengers = 1;
  String _category = '1º Clase';
  final _extras = <String, bool> {
    'Con equipaje': false,
    'Con servicio de restaurante': false,
    'Coche cama': false,
  };

  DateTime? _travelDate;
  String? _travelHour;

  void _showConfirmation() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => ConfirmationDialog(
        onCancel: () => {
          Navigator.pop(dialogContext),
          setState(() {
            _showReservationSummary = false;
          })
        },
        onConfirm: () {
          Navigator.pop(dialogContext);
          setState(() {
            _showReservationSummary = false;
            _success = true;
          });
        },
      ),
    );
  }

  Future<void> _openCalendar() async {
    final selection = await Navigator.push<DateTimeSelection>(
      context,
      MaterialPageRoute(
        builder: (_) => const DateTimePage(),
      ),
    );

    if (selection == null || !mounted) return;

    setState(() {
      _travelDate = selection.date;
      _travelHour = selection.hour;
      _showReservationSummary = true;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const AppBanner(),
    body: Column(
      children: [
        Expanded(
          child: _success
              ? const SuccessPage()
              : _showReservationSummary
                  ? ReservationConfirmedPage(
                  origin: _origin,
                  destination: _destination,
                  passengers: _passengers,
                  category: _category,
                  extras: _extras,
                  date: _travelDate!,
                  hour: _travelHour!,
                )
              : FormPage(
              origin: _origin,
              destination: _destination,
              passengers: _passengers,
              category: _category,
              extras: _extras,
              onOriginChanged: (value) => setState(() => _origin = value),
              onDestinationChanged: (value) => setState(() => _destination = value),
              onPassengersChanged: (value) => setState(() => _passengers = value),
              onCategoryChanged: (value) => setState(() => _category = value),
              onExtraChanged: (label, selected) => setState(() => _extras[label] = selected),
              ),
        ),

        AppBottomButton(
          label: _success
              ? 'Entendido'
              : _showReservationSummary
                  ? 'Confirmar'
                  : 'Continuar',
          outlined: _success,
          onPressed: _success
              ? () => setState(() {
                  _success = false;
                  _showReservationSummary = false;
                  _travelDate = null;
                  _travelHour = null;
                })
              : _showReservationSummary
                  ? _showConfirmation
                  : _openCalendar,
        ),
      ]
    ),
  );
}
