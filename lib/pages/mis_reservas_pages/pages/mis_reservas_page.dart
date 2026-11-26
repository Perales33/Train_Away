import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:train_away/pages/mis_reservas_pages/widgets/reserva_card.dart';
import 'package:train_away/providers/reservas_provider.dart';

class MisReservasPage extends StatelessWidget {
  const MisReservasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final state = context.watch<ReservasProvider>();

    if (state.cargando) return const Center(child: CircularProgressIndicator());

    if (state.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 48, color: colors.error),
              const SizedBox(height: 12),
              Text(
                state.error!,
                textAlign: TextAlign.center,
                style: TextStyle(color: colors.onSurface, fontSize: 16),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  context.read<ReservasProvider>().chargeReservas();
                },
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      );
    }

    if (state.reservas.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsetsGeometry.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.history_toggle_off, size: 48, color: colors.primary),
              const SizedBox(height: 16),
              Text(
                "Todavía no tienes reservas confirmadas.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Cuando confirmes una nueva reserva, ésta aparecerá aquí",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return ReservaCard(reserva: state.reservas[index]);
      },
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemCount: state.reservas.length,
      padding: EdgeInsets.all(16),
    );
  }
}
