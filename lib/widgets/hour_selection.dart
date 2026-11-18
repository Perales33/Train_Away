import 'package:flutter/material.dart';
import 'package:train_away/widgets/form_dropdown.dart';

// Widget que permite elegir la hora de salida entre las horas disponibles.
class HourSelection extends StatelessWidget {
  const HourSelection({
    required this.hours,
    required this.selectedHour,
    required this.onChanged,
    super.key,
  });

  final List<String> hours;
  final String? selectedHour;
  final ValueChanged<String> onChanged;

  // Construye el selector reutilizando el desplegable común del formulario.
  @override
  Widget build(BuildContext context) => FormDropdown<String>(
    value: selectedHour ?? hours.first,
    values: hours,
    onChanged: (hour) => onChanged(hour ?? hours.first),
  );
}
