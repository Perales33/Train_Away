import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:train_away/widgets/elements_styles/bottom_button.dart';
import 'package:train_away/widgets/hour_selector/hour_selection.dart';
import 'package:train_away/mocks/mock_service.dart';
import 'package:train_away/models/clases_mock/travel_schedule.dart';
import 'package:train_away/models/clases_reserva/reserva_model.dart';

// Datos que la pantalla devuelve al completar la selección del viaje.
class DateTimeSelection {
  const DateTimeSelection({required this.date, required this.hour});

  final DateTime date;
  final String hour;
}

// Página donde se eligen la fecha y la hora de salida.
class DateTimePage extends StatefulWidget {
  const DateTimePage({super.key});

  @override
  State<DateTimePage> createState() => _DateTimePageState();
}

class _DateTimePageState extends State<DateTimePage> {
  // Limita el calendario al mes actual.
  static final now = DateTime.now();
  static final firstDay = DateTime(now.year, now.month, 1);
  static final lastDay = DateTime(now.year, now.month + 1, 0);

  DateTime? selectedDate;
  String? selectedHour;

  // Al igual que en el formulario y en el main.dart, se instancia un mock para cargar los datos, en este caso de las horas
  final MockService _mockService = const MockService();

  // Creamos dos variables para cargar los datos y saber cuando se han terminado de cargar
  List<TravelSchedule> _schedules = [];
  bool _loadingSchedules = true;

  // Definimos el estado inicial
  @override
  void initState() {
    super.initState();
    _loadSchedules();
  }

  // Método para cargar los horarios, como en los anteriores también para elementos futuros y con async para trabajar en paralelo
  Future<void> _loadSchedules() async {
    // Obtenemos todos los horarios
    final schedules = await _mockService.getSchedules();

    if (!mounted) {
      return;
    }

    // En caso de estar en la pantalla adecuada se asignan los horarios a la lista de horarios de la página,
    // y se indica que ya se ha terminado de cargar
    setState(() {
      _schedules = schedules;
      _loadingSchedules = false;
    });
  }

  // Devuelve la selección cuando se han indicado fecha y hora.
  void _confirmSelection() {
    final date = selectedDate;
    final hour = selectedHour;

    if (date == null || hour == null) return;

    context.read<ReservaModel>().setFechaHora(fecha: date, hora: hour);

    context.push('/reservar/confirmacion');
  }

  // Construye el calendario, el selector de hora y la acción para continuar.
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  Text(
                    'Fecha de salida',
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Center(
                    child: SizedBox(
                      width: 800,
                      child: Divider(
                        thickness: 2,
                        color: Colors.black.withAlpha(120),
                        indent: 50,
                        endIndent: 50,
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Calendario de selección individual dentro del mes actual.
                  // Para evitar crearlo de forma manual, que ocuparía mucho código, usamos directamente la dependencia
                  // syncfusion_date_picker que nos permite diseñar un calendario solamente aplicando los estilos.
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      width: 700,
                      decoration: BoxDecoration(
                        border: Border.all(color: colors.onSurface, width: 1.5),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Localizations.override(
                          context: context,
                          locale: const Locale('es', 'ES'),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SfDateRangePicker(
                              selectionMode:
                                  DateRangePickerSelectionMode.single,
                              selectionColor: colors.primary,
                              todayHighlightColor: colors.primary,

                              onSelectionChanged: (args) {
                                if (args.value is DateTime) {
                                  setState(() {
                                    selectedDate = args.value as DateTime;
                                  });
                                }
                              },
                              monthViewSettings:
                                  const DateRangePickerMonthViewSettings(
                                    showTrailingAndLeadingDates: false,
                                    firstDayOfWeek: DateTime.monday,
                                  ),
                              backgroundColor: colors.surface,
                              headerHeight: 60,
                              headerStyle: DateRangePickerHeaderStyle(
                                textAlign: TextAlign.center,
                                textStyle: TextStyle(
                                  color: colors.onSurface,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                                backgroundColor: colors.surface,
                              ),
                              minDate: firstDay,
                              maxDate: lastDay,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Horas disponibles para la fecha seleccionada',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: colors.inverseSurface,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Definimos el comportamiento del horario. En caso de seleccionar la fecha, aparecerán las opciones de las fechas, del contrario aparecerá solo el mensaje "Seleccione una fecha".
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100.0,
                      vertical: 4,
                    ),
                    child: selectedDate == null
                        ? const Text('Seleccione una fecha')
                        : _loadingSchedules
                        ? const Center(child: CircularProgressIndicator())
                        : _schedules.isEmpty
                        ? const Text('No hay horarios disponibles')
                        : HourSelection(
                            // Se cargan las horas desde el mock y se envian al Widget con el dropdown del horario (Mirar archivo: hour_selection.dart)
                            hours: _schedules
                                .map((schedule) => schedule.time)
                                .toList(),
                            selectedHour: selectedHour,
                            onChanged: (hour) {
                              setState(() => selectedHour = hour);
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),

          // Este botón se crea desde el main, pasandole como el label del botón que deberá crearse, y actualizará las variables
          // hora y fecha, para mostrarsela en la sección de reservation_confirmed
          AppBottomButton(label: 'Reservar', onPressed: _confirmSelection),
        ],
      ),
    );
  }
}
