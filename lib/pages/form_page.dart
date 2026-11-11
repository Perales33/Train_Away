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

  // Estaciones que se pueden elegir como origen o destino (Una por cada Provincia de España).
  static const stations = [
    // Andalucía
    'Estación de Almería',
    'Estación de Cádiz',
    'Estación de Córdoba',
    'Estación de Granada',
    'Estación de Huelva',
    'Estación de Jaén',
    'Estación de Málaga',
    'Estación de Sevilla',

    // Aragón
    'Estación de Huesca',
    'Estación de Teruel',
    'Estación de Zaragoza',

    // Asturias
    'Estación de Oviedo',

    // Cantabria
    'Estación de Santander',

    // Castilla-La Mancha
    'Estación de Albacete',
    'Estación de Ciudad Real',
    'Estación de Cuenca',
    'Estación de Guadalajara',
    'Estación de Toledo',

    // Castilla y León
    'Estación de Ávila',
    'Estación de Burgos',
    'Estación de León',
    'Estación de Palencia',
    'Estación de Salamanca',
    'Estación de Segovia',
    'Estación de Soria',
    'Estación de Valladolid',
    'Estación de Zamora',

    // Cataluña
    'Estación de Barcelona',
    'Estación de Girona',
    'Estación de Lleida',
    'Estación de Tarragona',

    // Comunidad Valenciana
    'Estación de Alicante',
    'Estación de Castellón',
    'Estación de Valencia',

    // Extremadura
    'Estación de Badajoz',
    'Estación de Cáceres',

    // Galicia
    'Estación de A Coruña',
    'Estación de Lugo',
    'Estación de Ourense',
    'Estación de Santiago de Compostela',

    // La Rioja
    'Estación de Logroño',

    // Comunidad de Madrid
    'Estación de Madrid',

    // Navarra
    'Estación de Pamplona',

    // País Vasco
    'Estación de Bilbao',
    'Estación de Donostia',
    'Estación de Vitoria-Gasteiz',

    // Región de Murcia
    'Estación de Murcia',
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
        // Usamos la clase FormFieldLabel y FormDropdown para definir los elementos que debe tener estos elementos.
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
                'Categoría',
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
        // Añadimos Sin tener que ir uno a uno cada widget de forma separada para los elementos extras (Operador de expansión '...')
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
