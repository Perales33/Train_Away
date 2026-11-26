import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:train_away/navigation/reserva_reinicio.dart';

import 'package:train_away/models/clases_reserva/reserva_model.dart';
import 'package:train_away/providers/reservas_provider.dart';
import 'package:train_away/providers/last_train_provider.dart';
import 'package:train_away/widgets/elements_styles/bottom_button.dart';
import 'package:train_away/pages/reservar_pages/confirmation_dialog.dart';

// Página que resume los datos del viaje antes de confirmarlo.
class ReservationConfirmedPage extends StatelessWidget {

  const ReservationConfirmedPage({super.key});

  Future<void> _confirmReserva(BuildContext context) async {
    final confirmar = await showDialog<bool>(
      context: context, 
      builder: (_) => const ConfirmationDialog() 
    );

    if(!context.mounted || confirmar == null) { return; }

    if(confirmar == false) {
      await reiniciarReserva(context);
      return;
    }

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
    final colors = Theme.of(context).colorScheme;
    final reserva = context.watch<ReservaModel>();
    return Scaffold(
      body: Column( 
        children: [
          Expanded(
            child: SingleChildScrollView (
              padding: const EdgeInsets.all(16),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(),
                  child: Container(
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
                            'Resumen de la reserva',
                            style: TextStyle(
                              color: colors.onSurface,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 18),

                        _infoTile(colors, 'Origen', reserva.origen),
                        _infoTile(colors, 'Destino', reserva.destino),
                        Row(
                          children: [
                            Expanded(child: _infoTile(colors, 'Fecha', reserva.fecha == null ? 'Sin seleccionar' : _formatDate(reserva.fecha!))),
                            const SizedBox(width: 10),
                            Expanded(child: _infoTile(colors, 'Hora', reserva.hora ?? 'Sin seleccionar')),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: _infoTile(colors, 'Pasajeros', '${reserva.pasajeros}'),
                            ),
                            const SizedBox(width: 10),
                            Expanded(child: _infoTile(colors, 'Categoría', reserva.categoria)),
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
                        ...reserva.opciones.entries.map(
                          (entry) => _valueBox(colors, '${entry.value ? 'Con' : 'Sin'} ${entry.key}')
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          AppBottomButton(label: 'Confirmar', onPressed: () => _confirmReserva(context))
        ],
      ),
    );
  }
  
  // Presenta una etiqueta junto al valor correspondiente.
  Widget _infoTile(ColorScheme colors, String label, String value)
  {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
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
  // Estilos para mostrar el valor dentro de la caja con los datos de la confirmación de reserva.
  Widget _valueBox(ColorScheme colors, String value) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: EdgeInsets.only(bottom: 7),
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

  // Formatea la fecha con día y mes de dos cifras.
  String _formatDate(DateTime value) =>
    '${value.day.toString().padLeft(2, '0')} / '
    '${value.month.toString().padLeft(2, '0')} / ${value.year}';
}