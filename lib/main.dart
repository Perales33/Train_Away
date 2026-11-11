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

// Inicia la aplicación Train Away.
void main() => runApp(const TrainAwayApp());

class TrainAwayApp extends StatelessWidget {
  const TrainAwayApp({super.key});

  // Widget de la aplicación
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Train Away',
    debugShowCheckedModeBanner: false,
    
    // Permitir conversión de elementos para traducirlos a inglés o español, según el sistema
    supportedLocales: const [Locale('en'), Locale('es')],
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      SfGlobalLocalizations.delegate,
    ],
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.navy,
        primary: AppColors.navy,
      ),
      fontFamily: 'DM Sans',
    ),
    home: const ConfirmationPage(),
  );
}

// Enumeración para indicar en que paso se encuentra del formulario
enum ReservationStep { form, summary, success }

// Clase ConfirmationPage para declarar el esado inicial de la aplicaciÃ³n
class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({super.key});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {

  // Variables con valores por defecto
  String _origin = 'Estación de Almería';
  String _destination = 'Estación de Cádiz';
  int _passengers = 1;
  String _category = '1ª Clase';
  final _extras = <String, bool>{
    'Con equipaje': false,
    'Con servicio de restaurante': false,
    'Coche cama': false,
  };

  // Variables para elementos futuros con la fecha y la hora
  DateTime? _travelDate;
  String? _travelHour;

  ReservationStep _step = ReservationStep.form;

  // Función para ver cuando se puede ejecutar el dialog para confirmar la reserva
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

  // Abre la selección de fecha y hora y guarda los datos recibidos.
  Future<void> _openCalendar() async {
    final selection = await Navigator.push<DateTimeSelection>(
      context,
      MaterialPageRoute(builder: (_) => const DateTimePage()),
    );

    if (selection == null || !mounted) return;

    setState(() {
      _travelDate = selection.date;
      _travelHour = selection.hour;
      _step = ReservationStep.summary;
    });
  }

  // Restablece los datos para empezar una nueva reserva.
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

  // Widget para enviar los datos entre páginas (Formulario -> Fecha y Hora (Se guarda en una función a aparte) -> Resumen de Reserva)
  @override
  Widget build(BuildContext context) {
    final currentPage = switch (_step) {
      // Guardar los datos del formulario para actualizarlos cuando se cambie cualquier valor
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
        onExtraChanged: (label, selected) =>
            setState(() => _extras[label] = selected),
      ),

      // Enviar los datos confirmados 
      ReservationStep.summary => ReservationConfirmedPage(
        origin: _origin,
        destination: _destination,
        passengers: _passengers,
        category: _category,
        extras: _extras,
        date: _travelDate!,
        hour: _travelHour!,
      ),

      // Mostrar por último la página de confirmación de reserva
      ReservationStep.success => const SuccessPage(),
    };

    // Para manejar los estado del botón, comprobamos si se cumple que esté en una sección u otra de la aplicación
    final isSummary = _step == ReservationStep.summary;
    final isSuccess = _step == ReservationStep.success;

    // Manejo de la página de la aplicación que se va a mostrar
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
                : 'Reservar',
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
