import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:train_away/theme/app_colors.dart';
import 'package:train_away/models/reserva_model.dart';
import 'package:train_away/providers/reservas_provider.dart';
import 'package:train_away/providers/last_train_provider.dart';
import 'package:train_away/widgets/app_banner.dart';
import 'package:train_away/widgets/app_bottom_button.dart';
import 'package:train_away/pages/confirmation_dialog.dart';

// Página que resume los datos del viaje antes de confirmarlo.
class ReservationConfirmedPage extends StatelessWidget {

  const ReservationConfirmedPage({super.key});

  Future<void> _confirmReserva(BuildContext context) async {
    final confirmar = await showDialog<bool>(
      context: context, 
      builder: (_) => const ConfirmationDialog() 
    );

    if(!context.mounted || confirmar != true) { return; }

    try {
      final model = context.read<ReservaModel>();
      final reserva = model.crearReserva();

      await context.read<ReservasProvider>().saveReserva(reserva);

      if(!context.mounted) { return; }

      await context.read<LastTrainProvider>().save(origen: reserva.origen, destino: reserva.destino);

      if(!context.mounted) { return; }

      context.go('/reserva-confirmada');
    } 
    catch (e) {
      if(!context.mounted) { return; }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo guardar la reserva')
        )
      );
    }
  }

  // Construye la tarjeta con el resumen completo de la reserva.
  @override
  Widget build(BuildContext context) {
    final reserva = context.watch<ReservaModel>();
    return Scaffold(
      appBar: AppBanner(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
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

                  _infoTile('Origen', reserva.origen),
                  _infoTile('Destino', reserva.destino),
                  Row(
                    children: [
                      Expanded(child: _infoTile('Fecha', reserva.fecha != null ? 'Sin seleccionar' : _formatDate(reserva.fecha!))),
                      const SizedBox(width: 10),
                      Expanded(child: _infoTile('Hora', reserva.hora ?? 'Sin seleccionar')),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _infoTile('Número de pasajeros', '$reserva.pasajeros'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: _infoTile('Categoría', reserva.categoria)),
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
                  ...reserva.opciones.entries.map(
                    (entry) => _valueBox('${entry.value ? 'Con' : 'Sin'} ${entry.key}')
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppBottomButton(
        label: 'Confirmar', 
        onPressed: () => _confirmReserva(context)
      ),
    );
  }
  
  // Presenta una etiqueta junto al valor correspondiente.
  Widget _infoTile(String label, String value)
  {
    return Padding(
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
  }
  // Estilos para mostrar el valor dentro de la caja con los datos de la confirmación de reserva.
  Widget _valueBox(String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: const EdgeInsets.only(bottom: 7),
      decoration: BoxDecoration(
        color: AppColors.surfaceGrey,
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
  }

  // Formatea la fecha con día y mes de dos cifras.
  String _formatDate(DateTime value) =>
    '${value.day.toString().padLeft(2, '0')} / '
    '${value.month.toString().padLeft(2, '0')} / ${value.year}';
}