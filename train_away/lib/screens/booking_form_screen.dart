import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/form_dropdown.dart';
import '../widgets/form_field_label.dart';

class BookingFormScreen extends StatelessWidget {
  const BookingFormScreen({
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

  static const stations = [
    "Estación Norte de Madrid",
    "Estación Sur de Barcelona",
    "Estación de Centro de Valencia",
  ];

  static const categories = [
    "1º Clase",
    "2º Clase",
  ];

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            const FormFieldLabel('Origen'),
            FormDropdown<String>(
              value: origin, 
              values: stations, 
              onChanged: (value) { if (value != null) onOriginChanged(value); }
            ),
            
            const SizedBox(height: 12),
            const FormFieldLabel('Destino'),
            FormDropdown<String>(
              value: destination, 
              values: stations, 
              onChanged: (value) { if (value != null) onDestinationChanged(value); }
            ),
          
            const SizedBox(height: 42),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                Expanded(
                  child: _selectField(
                      'Pasajeros', 
                      FormDropdown<int>(
                        value: passengers, 
                        values: List.generate(8, (index) => index + 1), 
                        onChanged: (value) { if (value != null) onPassengersChanged(value); }
                      )
                  )
                ),
            
            const SizedBox(width: 28),
            Expanded(
              child: _selectField(
                'Categoría', 
                FormDropdown<String>(
                  value: category, 
                  values: categories, 
                  onChanged: (value) { if (value != null) onCategoryChanged(value); }
                )
              )
            ),
          ]
        ),

        const SizedBox(height: 42),
        const FormFieldLabel('Opciones de viaje'),
        const SizedBox(height: 8),
        ...extras.entries.map((entry) => _option(entry.key, entry.value)),
      ]
    ),
  );

  Widget _selectField(String label, Widget child) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [FormFieldLabel(label), child]);

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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
              ),
              
              const SizedBox(width: 5),
              Text(label, style: const TextStyle(color: AppColors.navy, fontWeight: FontWeight.w600, fontSize: 15)),
          ]),
        ),
      );
}
