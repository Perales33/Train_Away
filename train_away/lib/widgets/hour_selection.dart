import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: hours.map((hour) {
      return ChoiceChip(
        label: Text(hour),
        selected: selectedHour == hour,
        onSelected: (_) => onChanged(hour),
      );
    }).toList(),
  );
}
