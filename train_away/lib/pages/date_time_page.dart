import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:train_away/theme/app_colors.dart';
import 'package:train_away/widgets/app_banner.dart';
import 'package:train_away/widgets/app_bottom_button.dart';
import 'package:train_away/widgets/hour_selection.dart';

class DateTimeSelection {
  const DateTimeSelection({required this.date, required this.hour});

  final DateTime date;
  final String hour;
}

enum ReservationStep { form, summary, success }

class DateTimePage extends StatefulWidget {
  const DateTimePage({super.key});

  @override
  State<DateTimePage> createState() => _DateTimePageState();
}

class _DateTimePageState extends State<DateTimePage> {
  static final now = DateTime.now();
  static final firstDay = DateTime(now.year, now.month, 1);
  static final lastDay = DateTime(now.year, now.month + 1, 0);

  DateTime? selectedDate;
  String? selectedHour;

  void _confirmSelection() {
    final date = selectedDate;
    final hour = selectedHour;

    if (date == null || hour == null) return;

    Navigator.pop(context, DateTimeSelection(date: date, hour: hour));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const AppBanner(),
    body: Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                const Text(
                  'Fecha de salida',
                  style: TextStyle(
                    color: AppColors.black,
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

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: 700,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.darkColor,
                        width: 1.5,
                      ),
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
                            selectionMode: DateRangePickerSelectionMode.single,
                            selectionColor: AppColors.burgundy,
                            todayHighlightColor: AppColors.black.withAlpha(100),

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
                            backgroundColor: AppColors.white,
                            headerHeight: 60,
                            headerStyle: const DateRangePickerHeaderStyle(
                              textAlign: TextAlign.center,
                              textStyle: TextStyle(
                                color: AppColors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                              backgroundColor: AppColors.white,
                            ),
                            minDate: firstDay,
                            maxDate: lastDay,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Horas disponibles para la fecha seleccionada',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100.0,
                    vertical: 4,
                  ),
                  child: selectedDate != null
                      ? HourSelection(
                          selectedHour: selectedHour,
                          onChanged: (hour) =>
                              setState(() => selectedHour = hour),
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black.withAlpha(120),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "N/A",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withAlpha(120),
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down_sharp,
                                color: Colors.black.withAlpha(120),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),

        AppBottomButton(label: 'Continuar', onPressed: _confirmSelection),
      ],
    ),
  );
}
