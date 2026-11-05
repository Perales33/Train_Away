import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:train_away/theme/app_colors.dart';
import 'package:train_away/widgets/app_banner.dart';
import 'package:train_away/widgets/app_bottom_button.dart';
import 'package:train_away/widgets/hour_selection.dart';

class DateTimeSelection {
  const DateTimeSelection({
    required this.date,
    required this.hour,
  });

  final DateTime date;
  final String hour;
}

enum ReservationStep
{
  form,
  summary,
  success,
}

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

    Navigator.pop(
      context,
      DateTimeSelection(date: date, hour: hour),
    );
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
                        color: AppColors.navy,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    
                    Center(
                      child: SizedBox(
                        width: 800,
                        child: Divider(
                          thickness: 2,
                          color: Colors.grey,
                          indent: 200,
                          endIndent: 200,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    Container(
                      width: 700,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.navy, width: 1.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Localizations.override(
                        context: context,
                        locale: const Locale('es', 'ES'),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SfDateRangePicker(
                            selectionMode: DateRangePickerSelectionMode.single,
                            onSelectionChanged: (args) {
                              if (args.value is DateTime) {
                                setState(() {
                                  selectedDate = args.value as DateTime;
                                });
                              }
                            },
                            monthViewSettings: const DateRangePickerMonthViewSettings(
                              showTrailingAndLeadingDates: false,
                            ),
                            backgroundColor: Colors.white,
                            headerHeight: 60,
                            headerStyle: const DateRangePickerHeaderStyle(
                              textAlign: TextAlign.center,
                              textStyle: TextStyle(
                                color: AppColors.navy,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                              backgroundColor: Colors.white,
                            ),
                            minDate: firstDay,
                            maxDate: lastDay,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    const Text(
                      'Horas disponibles',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.navy,
                      ),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    HourSelection(
                      selectedHour: selectedHour,
                      onChanged: (hour) => setState(() => selectedHour = hour),
                    ),
                  ],
                ),
              ),
            ),
            AppBottomButton(
              label: 'Continuar',
              onPressed: _confirmSelection,
            ),
          ],
        ),
      );
}
