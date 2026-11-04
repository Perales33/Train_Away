import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../theme/app_colors.dart';
import '../widgets/app_banner.dart';

class BookingDateTimeScreen extends StatelessWidget {
  const BookingDateTimeScreen({required this.onContinue, super.key});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const AppBanner(),
        body: Column(children: [
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Fecha de salida ',
                style: TextStyle(color: AppColors.navy, fontSize: 30, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Center(
            child: SizedBox(
              width: 250,
              child: Divider(
                thickness: 2,
                color: Colors.grey,
              ),
            ),
          ), 
          Expanded(
            flex: 1,
            borderB
            child: Container(
              color: AppColors.navy,
              child: SfDateRangePicker(
                selectionMode: DateRangePickerSelectionMode.single,
                monthViewSettings: const DateRangePickerMonthViewSettings(
                  showTrailingAndLeadingDates: true,
                ),
                backgroundColor: Colors.white,
                headerHeight: 60,
                headerStyle: const DateRangePickerHeaderStyle(
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(color: AppColors.navy, fontSize: 20, fontWeight: FontWeight.w600),
                  backgroundColor: Colors.white,
                ),
                
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: 192,
              height: 46,
              child: FilledButton(
                onPressed: onContinue,
                child: const Text('Continuar'),
              ),
            ),
          ),
        ]),
      );
}
