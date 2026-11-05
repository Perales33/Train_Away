import 'package:flutter/material.dart';

import 'package:train_away/theme/app_colors.dart';

class ReservationConfirmedPage extends StatelessWidget {
  const ReservationConfirmedPage({
    required this.origin,
    required this.destination,
    required this.passengers,
    required this.category,
    required this.extras,
    required this.date,
    required this.hour,
    super.key,
  });

  final String origin;
  final String destination;
  final int passengers;
  final String category;
  final Map<String, bool> extras;
  final DateTime date;
  final String hour;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.navy),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Resumen de la reserva',
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              const SizedBox(height: 18),

              _infoTile('Origen', origin),
              _infoTile('Destino', destination),
              Row(
                children: [
                  Expanded(child: _infoTile('Fecha', _formatDate(date))),
                  const SizedBox(width: 10),
                  Expanded(child: _infoTile('Hora', hour)),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _infoTile('Número de pasajero', '$passengers'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: _infoTile('Categoría', category)),
                ],
              ),

              const SizedBox(height: 8),

              const Text(
                'Opciones de viaje',
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              ...extras.entries.map((entry) {
                final option = entry.key.replaceFirst('Con', '');
                return _valueBox('${entry.value ? 'Con' : 'Sin'} $option');
              }),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _infoTile(String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.navy,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        _valueBox(value),
      ],
    ),
  );

  Widget _valueBox(String value) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    margin: const EdgeInsets.only(bottom: 7),
    decoration: BoxDecoration(
      color: const Color(0xFFE7E6E7),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      value,
      style: const TextStyle(
        color: AppColors.navy,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  String _formatDate(DateTime value) =>
    '${value.day.toString().padLeft(2, '0')} / '
    '${value.month.toString().padLeft(2, '0')} / ${value.year}';
}
