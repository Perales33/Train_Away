import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

import 'package:train_away/pages/confirmation_dialog.dart';
import 'package:train_away/pages/date_time_page.dart';
import 'package:train_away/pages/form_page.dart';
import 'package:train_away/pages/reservation_confirmed.dart';
import 'package:train_away/pages/success_page.dart';
import 'package:train_away/providers/last_train_provider.dart';
import 'package:train_away/providers/reservas_provider.dart';
import 'package:train_away/theme/app_colors.dart';
import 'package:train_away/widgets/app_bottom_button.dart';
import 'package:train_away/widgets/app_banner.dart';
import 'package:train_away/mocks/mock_service.dart';
import 'package:train_away/models/stations.dart';
import 'package:train_away/models/travel_category.dart';
import 'package:train_away/models/travel_option.dart';
import 'package:train_away/models/reserva_model.dart';


// Inicia la aplicación Train Away.
void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ReservaModel()
      ),
      ChangeNotifierProvider(
        create: (_) => LastTrainProvider()
      ),
      /*
      ChangeNotifierProvider(
        create: (_) => ReservasProvider(ReservasDatabase.instance),
      )*/
    ],
    child: const TrainAwayApp())
  );
  

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
  String _origin = '';
  String _destination = '';
  int _passengers = 1;
  String _category = '';
  Map<String, bool> _extras = {};

  // Se instancia un mock para cargar los datos simulando la base de datos
  final MockService _mockService = const MockService();

  // Creamos tres listas para guardar todos los datos de las clases. No se crea el de horarios, porque ese se gestiona desde su propia página.
  List <Station> _stations = [];
  List <TravelCategory> _categories = [];
  List <TravelOption> _options = [];

  // Variable que permite indicar que ya se han terminado de cargar los datos
  bool _loading = true;

  // Definimos que los datos se carguen desde el principio
  @override
  void initState()
  {
    super.initState();
    _loadMockData();
  }

  // Método para cargar los datos del mock
  Future<void> _loadMockData() async
  {
    // Guardamos todos los datos en una variable para gestionar en que elemento lista irán
    final results = await Future.wait([
      _mockService.getStations(),
      _mockService.getCategories(),
      _mockService.getTravelOptions()
    ]);

    // Comprobamos la pantalla actual
    if(!mounted) { return; }

    // Cargamos los datos en cada lista para poder emplearlos en la aplicación. Además, indicamos que ya se han terminado de cargar los datos poniendo a false la variable _loading.
    // Por último, definimos cual es el estado inicial de las variables Origen, Destino, Categoria y el estado inicial de los extras (false)
    setState(() {
      _stations = results[0] as List<Station>;
      _categories = results[1] as List<TravelCategory>;
      _options = results[2] as List<TravelOption>;

      _origin = _stations.first.name;
      _destination = _stations[1].name;
      _category = _categories.first.name;
      _extras = {for(final option in _options) option.name: false};

      _loading = false;
    });
  }

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
      _origin = _stations.first.name;
      _destination = _stations[1].name;
      _passengers = 1;
      _category = _categories.first.name;
      _extras = {for(final option in _options) option.name: false};
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

    // Para manejar los estado de la página, comprobamos si se cumple que esté en una sección u otra de la aplicación
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
