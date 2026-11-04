import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

import 'screens/booking_confirmation_dialog.dart';
import 'screens/booking_date_date_screen.dart';
import 'screens/booking_form_screen.dart';
import 'screens/booking_success_screen.dart';
import 'theme/app_colors.dart';
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
          fontFamily: 'Roboto',
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

  void _showConfirmation(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => BookingConfirmationDialog(
        onCancel: () => Navigator.pop(dialogContext),
        onConfirm: () {
          Navigator.pop(dialogContext);
          Navigator.pop(context);
          setState(() => _success = true);
        },
      ),
    );
  }

  void _openCalendar() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => BookingDateTimeScreen(
          onContinue: () => _showConfirmation(context),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const AppBanner(),
    body: Column(
      children: [
        Expanded(
          child: _success
              ? const BookingSuccessScreen()
              : BookingFormScreen(
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

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFFBDBDBD)))),
          child: Center(
            child: SizedBox(
              width: 192,
              height: 46,
              child: _success
                  ? OutlinedButton(
                      style: OutlinedButton.styleFrom(foregroundColor: AppColors.navy, side: const BorderSide(color: AppColors.navy, width: 2.5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11))),
                      onPressed: () => setState(() => _success = false),
                      child: const Text('Entendido'),
                    )
                  : FilledButton(
                      style: FilledButton.styleFrom(backgroundColor: AppColors.navy, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11))),
                      onPressed: _openCalendar,
                      child: const Text('Continuar'),
                    ),
            ),
          ),
        ),
      ]
    ),
  );
}
