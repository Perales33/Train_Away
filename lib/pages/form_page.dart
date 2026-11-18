import 'package:flutter/material.dart';
import 'package:train_away/models/travel_category.dart';
import 'package:train_away/models/travel_option.dart';
import 'package:train_away/models/stations.dart';
import 'package:train_away/mocks/mock_service.dart';
import 'package:train_away/theme/app_colors.dart';
import 'package:train_away/widgets/form_dropdown.dart';
import 'package:train_away/widgets/form_field_label.dart';

// Página que recoge los datos principales y las preferencias del viaje.
class FormPage extends StatefulWidget
{
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

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  final MockService _mockService = const MockService();

  List <Station> _stations = [];
  List<TravelCategory> _categories = [];
  List<TravelOption> _options = [];

  bool _loading = true;
  
  @override 
  void initState()
  {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {

    final results = await Future.wait([
      _mockService.getStations(),
      _mockService.getCategories(),
      _mockService.getTravelOptions(),
    ]);
    
    if(!mounted) { return; }

    setState(() {
      _stations = results[0] as List<Station>;
      _categories = results[1] as List<TravelCategory>;
      _options = results[2] as List<TravelOption>;
      _loading = false;
    });
  }
  
  
  // Construye los campos de trayecto, pasajeros, clase y opciones adicionales.
  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FormFieldLabel('Origen'),
          FormDropdown<String>(
            value: widget.origin,
            values: _stations
                .map((station) => station.name)
                .where((name) => name != widget.destination)
                .toList(),
            onChanged: (value) {
              if (value != null) widget.onOriginChanged(value);
            },
          ),
          const SizedBox(height: 12),
          const FormFieldLabel('Destino'),
          FormDropdown<String>(
            value: widget.destination,
            values: _stations
                .map((station) => station.name)
                .where((name) => name != widget.origin)
                .toList(),
            onChanged: (value) {
              if (value != null) widget.onDestinationChanged(value);
            },
          ),
          const SizedBox(height: 42),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _selectField(
                  'Pasajeros',
                  FormDropdown<int>(
                    value: widget.passengers,
                    values: List.generate(8, (index) => index + 1),
                    onChanged: (value) {
                      if (value != null) widget.onPassengersChanged(value);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 28),
              Expanded(
                child: _selectField(
                  'Categoría',
                  FormDropdown<String>(
                    value: widget.category,
                    values: _categories.map((category) => category.name).toList(),
                    onChanged: (value) {
                      if (value != null) widget.onCategoryChanged(value);
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 42),
          const FormFieldLabel('Opciones de viaje'),
          const SizedBox(height: 8),
          ..._options.map(
            (option) => _option(
              option.name,
              widget.extras[option.name] ?? false,
            ),
          ),
        ],
      ),
    );
  }

  // Agrupa la etiqueta de un campo con su control de selección.
  Widget _selectField(String label, Widget child) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [FormFieldLabel(label), child],
  );

  // Construye una opción seleccionable para personalizar el viaje.
  Widget _option(String label, bool selected) => InkWell(
    onTap: () => widget.onExtraChanged(label, !selected),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            height: 34,
            child: Checkbox(
              value: selected,
              onChanged: (value) => widget.onExtraChanged(label, value ?? false),
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
