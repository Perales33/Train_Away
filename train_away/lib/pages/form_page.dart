import 'package:flutter/material.dart';

import 'package:train_away/theme/app_colors.dart';
import 'package:train_away/widgets/form_dropdown.dart';
import 'package:train_away/widgets/form_field_label.dart';

// Página que recoge los datos principales y las preferencias del viaje.
class FormPage extends StatelessWidget {
  const FormPage({
    required this.origin,
    required this.destination,
    required this.passengers,
    required this.category,
    required this.extras,
    required this.onOriginChanged,
    required this.onDestinationChanged,
    required this.onPassengersChanged,
    required this.onCategoryChanged,
    required this.onExtraChanged,
    super.key,
  });


  final String origin;
  final String destination;
  final int passengers;
  final String category;
  final Map<String, bool> extras;
  final ValueChanged<String> onOriginChanged;
  final ValueChanged<String> onDestinationChanged;
  final ValueChanged<int> onPassengersChanged;
  final ValueChanged<String> onCategoryChanged;
  final void Function(String label, bool selected) onExtraChanged;

  // Estaciones que se pueden elegir como origen o destino.
  static const stations = [
    'Estación Norte de Madrid',
    'Estación Sur de Barcelona',
    'Estación de Centro de Valencia',
  ];

  // Clases disponibles para el viaje.
  static const categories = ['1ª Clase', '2ª Clase'];

  // Construye los campos de trayecto, pasajeros, clase y opciones adicionales.
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(16, 14, 16, 28),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormFieldLabel('Origen'),
        FormDropdown<String>(
          value: origin,
          values: FormPage.stations
              .where((station) => station != destination)
              .toList(),
          onChanged: (value) {
            if (value != null) onOriginChanged(value);
          },
        ),

        const SizedBox(height: 12),

        const FormFieldLabel('Destino'),
        FormDropdown<String>(
          value: destination,
          values: FormPage.stations
              .where((station) => station != origin)
              .toList(),
          onChanged: (value) {
            if (value != null) onDestinationChanged(value);
          },
        ),
        const SizedBox(height: 42),
        // Organiza los campos de pasajeros y clase en la misma fila.
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _selectField(
                'Pasajeros',
                FormDropdown<int>(
                  value: passengers,
                  values: List.generate(8, (index) => index + 1),
                  onChanged: (value) {
                    if (value != null) onPassengersChanged(value);
                  },
                ),
              ),
            ),

            const SizedBox(width: 28),

            Expanded(
              child: _selectField(
                'Categorí­a',
                FormDropdown<String>(
                  value: category,
                  values: categories,
                  onChanged: (value) {
                    if (value != null) onCategoryChanged(value);
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 42),
        const FormFieldLabel('Opciones de viaje'),
        const SizedBox(height: 8),
        ...extras.entries.map((entry) => _option(entry.key, entry.value)),
      ],
    ),
  );

  // Agrupa la etiqueta de un campo con su control de selección.
  Widget _selectField(String label, Widget child) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [FormFieldLabel(label), child],
  );

  // Construye una opción seleccionable para personalizar el viaje.
  Widget _option(String label, bool selected) => InkWell(
    onTap: () => onExtraChanged(label, !selected),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            height: 34,
            child: Checkbox(
              value: selected,
              onChanged: (value) => onExtraChanged(label, value ?? false),
              activeColor: AppColors.navy,
              side: const BorderSide(color: AppColors.navy, width: 2.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),

          const SizedBox(width: 5),

          Text(
            label,
            style: const TextStyle(
              color: AppColors.navy,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ],
      ),
    ),
  );
}
