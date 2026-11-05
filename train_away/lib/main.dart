import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

import 'package:train_away/pages/confirmation_dialog.dart';
import 'package:train_away/pages/date_time_page.dart';
import 'package:train_away/pages/form_page.dart';
import 'package:train_away/pages/reservation_confirmed.dart';
import 'package:train_away/pages/success_page.dart';
import 'package:train_away/theme/app_colors.dart';
import 'package:train_away/widgets/app_bottom_button.dart';
import 'package:train_away/widgets/app_banner.dart';

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
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.navy,
        primary: AppColors.navy,
      ),
      fontFamily: 'DM Sans',
    ),
    home: const ConfirmationPage(),
  );
}

enum ReservationStep { form, summary, success }

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({super.key});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  String _origin = 'Estación Norte de Madrid';
  String _destination = 'Estación Sur de Barcelona';
  int _passengers = 1;
  String _category = '1º Clase';
  final _extras = <String, bool>{
    'Con equipaje': false,
    'Con servicio de restaurante': false,
    'Coche cama': false,
  };

  DateTime? _travelDate;
  String? _travelHour;

  ReservationStep _step = ReservationStep.form;

  void _showConfirmation() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => ConfirmationDialog(
        onCancel: () {
          Navigator.pop(dialogContext);
          setState(() => _step = ReservationStep.form);
        },
        
        onConfirm: () {
          Navigator.pop(dialogContext);
          setState(() {
            _step = ReservationStep.success;
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
      _step = ReservationStep.summary;
    });
  }

  void _resetReservation() {
    setState(() {
      _step = ReservationStep.form;
      _origin = FormPage.stations.first;
      _destination = FormPage.stations[1];
      _passengers = 1;
      _category = FormPage.categories.first;
      for (final key in _extras.keys.toList()) {
        _extras[key] = false;
      }
      _travelDate = null;
      _travelHour = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = switch (_step) {
      ReservationStep.form => FormPage(
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
      
      ReservationStep.summary => ReservationConfirmedPage(
        origin: _origin,
        destination: _destination,
        passengers: _passengers,
        category: _category,
        extras: _extras,
        date: _travelDate!,
        hour: _travelHour!,
      ),

      ReservationStep.success => const SuccessPage(),
    };

    final isSummary = _step == ReservationStep.summary;
    final isSuccess = _step == ReservationStep.success;

    return Scaffold(
      appBar: AppBanner(onLogoTap: _resetReservation),
      body: Column(
        children: [
          Expanded(child: currentPage),
          AppBottomButton(
            label: isSuccess
                ? 'Entendido'
                : isSummary
                    ? 'Confirmar'
                    : 'Continuar',
            outlined: isSuccess,
            onPressed: isSuccess
                ? _resetReservation
                : isSummary
                    ? _showConfirmation
                    : _openCalendar,
          ),
        ],
      ),
    );
  }
}
