import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../theme/app_colors.dart';
import '../widgets/app_bottom_button.dart';
import '../widgets/app_banner.dart';

class BookingDateTimeScreen extends StatelessWidget {
  const BookingDateTimeScreen({required this.onContinue, super.key});

  final VoidCallback onContinue;
  static final ahora = DateTime.now();
  static final firstDay = DateTime(ahora.year, ahora.month, 1);
  static final lastDay = DateTime(ahora.year, ahora.month + 1, 0);
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
                      width: 800,
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
                            monthViewSettings:
                                const DateRangePickerMonthViewSettings(
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
                  ],
                ),
              ),
            ),
            AppBottomButton(label: 'Confirmar', onPressed: onContinue),
          ],
        ),
      );
}
