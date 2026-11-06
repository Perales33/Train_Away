import 'package:flutter/material.dart';
import 'package:train_away/widgets/form_dropdown.dart';

class HourSelection extends StatelessWidget {
  const HourSelection({
    required this.selectedHour,
    required this.onChanged,
    super.key,
  });

  final String? selectedHour;
  final ValueChanged<String> onChanged;

  static const hours = [
    '07:00',
    '09:00',
    '11:00',
    '13:00',
    '15:00',
    '17:00',
    '19:00',
    '21:00',
  ];

  @override
  Widget build(BuildContext context) => FormDropdown<String>(
    value: selectedHour ?? hours.first,
    values: hours,
    onChanged: (hour) => onChanged(hour ?? hours.first),
  );
}
