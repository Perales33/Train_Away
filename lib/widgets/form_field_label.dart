import 'package:flutter/material.dart';
import 'package:train_away/theme/app_colors.dart';

// Widget que muestra el nombre o la descripción de un campo del formulario.
class FormFieldLabel extends StatelessWidget {
  const FormFieldLabel(this.label, {super.key});

  // Texto descriptivo que se presenta junto al campo.
  final String label;

  // Construye la etiqueta con el formato compartido por la aplicación.
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      label,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      ),
    ),
  );
}
