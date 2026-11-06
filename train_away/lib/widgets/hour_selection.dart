import 'package:flutter/material.dart';
import 'package:train_away/widgets/form_dropdown.dart';

// Widget que permite elegir la hora de salida entre las horas disponibles.
class HourSelection extends StatelessWidget {
  const HourSelection({
    required this.selectedHour,
    required this.onChanged,
    super.key,
  });

  final String? selectedHour;
  final ValueChanged<String> onChanged;

  // Horas de salida que se ofrecen en el desplegable.
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

  // Construye el selector reutilizando el desplegable común del formulario.
  @override
  Widget build(BuildContext context) => FormDropdown<String>(
    value: selectedHour ?? hours.first,
    values: hours,
    onChanged: (hour) => onChanged(hour ?? hours.first),
  );
}
