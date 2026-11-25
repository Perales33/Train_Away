import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:train_away/models/reserva.dart';
import 'package:train_away/models/travel_category.dart';
import 'package:train_away/models/travel_option.dart';
import 'package:train_away/models/stations.dart';
import 'package:train_away/mocks/mock_service.dart';
import 'package:train_away/theme/app_colors.dart';
import 'package:train_away/widgets/form_dropdown.dart';
import 'package:train_away/widgets/form_field_label.dart';
import 'package:train_away/models/reserva_model.dart';
import 'package:train_away/providers/last_train_provider.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Página que recoge los datos principales y las preferencias del viaje.
class FormPage extends StatefulWidget
{
  // Constructor con todas las variables y métodos de las variables
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

  // Definimos todas las variables empleadas y los métodos que nos permitirán actualizar los datos en las diferentes pantallas de la aplicación
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

  // Instanciamos un mockService para poder cargar todos los datos, simulando una base de datos
  final MockService _mockService = const MockService();

  // Tres listas para guardar todos los datos procedentes del mock
  List <Station> _stations = [];
  List<TravelCategory> _categories = [];
  List<TravelOption> _options = [];

  // Variable para definir cuando se han terminado de cargar los datos
  bool _loading = true;
  
  // Inicializar el método para cargar los datos desde el principio de la aplicación (Futures)
  @override 
  void initState()
  {
    super.initState();
    _loadData();
  }

  // Método con elementos futuros, que nos permite cargar los datos del mock, es decir, trabajamos en paralelo
  Future<void> _loadData() async {

    // Guardamos todos los datos en una única variable, teniendo en cuenta que se bloquea el hilo dedicado a ello
    // hasta que no se carguen todos los datos.
    final results = await Future.wait([
      _mockService.getStations(),
      _mockService.getCategories(),
      _mockService.getTravelOptions(),
    ]);
    
    if(!mounted) { return; }

    final stations = results[0] as List<Station>;
    final categories = results[1] as List<TravelCategory>;
    final options = results[2] as List<TravelOption>;

    final lastTrain = context.read<LastTrainProvider>();
    await lastTrain.charge();

    final reserva = context.read<ReservaModel>();

    final defaultOrigen = _stations.first.name;
    final defaultDestino = _stations[1].name;

    final savedOrigen = lastTrain.origen;
    final savedDestino = lastTrain.destino;
    
  
    final origen = reserva.origen.isNotEmpty ? reserva.origen : savedOrigen ?? defaultOrigen;
    final destino = reserva.destino.isNotEmpty ? reserva.destino : savedDestino ?? defaultDestino;

    reserva.setTrayecto(
      origen: origen,
      destino: destino
    );

    if(reserva.categoria.isEmpty && categories.isNotEmpty) {
      reserva.setCategorias(categories.first.name);
    }

    if(reserva.opciones.isEmpty) {
      reserva.setOpciones({
        for(final option in options) option.name: false
      });
    }

    // Definimos donde se guardarán los datos de cada lista, y además, indicamos que los datos se han terminado de cargar en la variable _loading
    setState(() {
      _stations = stations;
      _categories = categories;
      _options = options;
      _loading = false;
    });
  }
  
  
  // Construye los campos de trayecto, pasajeros, clase y opciones adicionales.
  @override
  Widget build(BuildContext context) {

    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final reserva = context.watch<ReservaModel>();

    final stationNames = _stations.map((station) => station.name).toList();
    final categoryNames = _categories.map((category) => category.name).toList();

    final origen = stationNames.contains(reserva.origen) ? reserva.origen : stationNames.first;
    final destino = stationNames.contains(reserva.destino) && reserva.destino != origen 
    ? reserva.destino : stationNames.firstWhere((name) => name != origen);

    final categoria = categoryNames.contains(reserva.categoria) ? reserva.categoria : categoryNames.first;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FormFieldLabel('Origen'),
          FormDropdown<String>(
            // Con value definimos el valor por defecto que se cargará tanto para el Origen, el Destino, la Categoría y el número de pasajeros, aunque cada uno en su elemento, 
            // y con values definimos los valores que emplearán los dropdowns.
            value: origen,
            values: stationNames.where((name) => name != destino).toList(),
            onChanged: (value) {
              if (value != null) context.read<ReservaModel>().setOrigen(value);
            },
          ),
          const SizedBox(height: 12),
          const FormFieldLabel('Destino'),
          FormDropdown<String>(
            value: destino,
            values: stationNames.where((name) => name != origen).toList(),
            onChanged: (value) {
              if (value != null) context.read<ReservaModel>().setDestino(value);
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
                    value: reserva.pasajeros,
                    values: List.generate(8, (index) => index + 1),
                    onChanged: (value) {
                      if (value != null) context.read<ReservaModel>().setPasajeros(value);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 28),
              Expanded(
                child: _selectField(
                  'Categoría',
                  FormDropdown<String>(
                    value: categoria,
                    values: categoryNames,
                    onChanged: (value) {
                      if (value != null) context.read<ReservaModel>().setCategorias(value);
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 42),
          const FormFieldLabel('Opciones de viaje'),
          const SizedBox(height: 8),
          // Mediante el operador de propagación '...' insertamos todos los elementos dentro del mapa de opciones extras
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
