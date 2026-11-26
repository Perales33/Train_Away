import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:train_away/models/clases_reserva/reserva.dart';

class ReservaCard extends StatelessWidget {
  final Reserva reserva;
  const ReservaCard({super.key, required this.reserva});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final id = reserva.id;

    final multiplePasajeros = reserva.pasajeros >= 2
        ? "pasajeros"
        : "pasajero";
    final tickets = reserva.pasajeros >= 2 ? "tickets" : "ticket";
    return Card(
      color: colors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(14),
        side: BorderSide(color: colors.outline),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: CircleAvatar(
          backgroundColor: colors.primaryContainer,
          child: Icon(Icons.train_outlined, color: colors.onInverseSurface),
        ),
        title: Text(
          "${reserva.origen} → ${reserva.destino}",
          style: TextStyle(
            color: colors.onSurface,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsetsGeometry.only(top: 6),
          child: Text(
            "${reserva.formatDate} a las ${reserva.hora}h -  ${reserva.pasajeros} $tickets de $multiplePasajeros.",
            style: TextStyle(color: colors.onSurfaceVariant, fontSize: 14),
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: colors.primary),
        onTap: () => id == null ? null : context.push('/mis-reservas/$id'),
      ),
    );
  }
}
