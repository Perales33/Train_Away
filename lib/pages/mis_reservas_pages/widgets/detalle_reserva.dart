import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:train_away/models/clases_reserva/reserva.dart';
import 'package:train_away/widgets/elements_styles/bottom_button.dart';

class DetalleReserva extends StatelessWidget {
  final Reserva reserva;
  const DetalleReserva({super.key, required this.reserva});

  String _formatDateDetail(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.surface,
                border: Border.all(color: colors.outline),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Detalle de la reserva',
                      style: TextStyle(
                        color: colors.onSurface,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Center(
                    child: Text(
                      'Reserva #${reserva.id ?? '-'}',
                      style: TextStyle(
                        color: colors.onSurfaceVariant,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  _infoTile(colors, 'Origen', reserva.origen),
                  _infoTile(colors, 'Destino', reserva.destino),
                  Row(
                    children: [
                      Expanded(
                        child: _infoTile(colors, 'Fecha', _formatDateDetail(reserva.fecha)),
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: _infoTile(colors, 'Hora', reserva.hora)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _infoTile(
                          colors,
                          'Pasajeros',
                          '${reserva.pasajeros}',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _infoTile(
                          colors,
                          'Categoría',
                          reserva.categoria,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Opciones de viaje',
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),

                  if (reserva.opciones.isEmpty)
                    _valueBox(colors, 'Sin opciones seleccionadas')
                  else
                    ...reserva.opciones.entries.map(
                      (entry) => _valueBox(
                        colors,
                        '${entry.value ? 'Con' : 'Sin'} ${entry.key}',
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),

        AppBottomButton(
          label: 'Volver',
          outlined: true,
          onPressed: () => context.pop(),
        ),
      ],
    );
  }
}

Widget _infoTile(ColorScheme colors, String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: colors.onSurface,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        _valueBox(colors, value),
      ],
    ),
  );
}

Widget _valueBox(ColorScheme colors, String value) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    margin: const EdgeInsets.only(bottom: 7),
    decoration: BoxDecoration(
      color: colors.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      value,
      style: TextStyle(
        color: colors.onSurface,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
