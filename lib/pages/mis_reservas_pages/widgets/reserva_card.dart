import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:train_away/models/clases_reserva/reserva.dart';

class ReservaCard extends StatelessWidget {
  final Reserva _reserva;
  const ReservaCard({super.key, required this._reserva});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final id = _reserva.id;

    final multiplePasajeros = _reserva.pasajeros >= 2
        ? "pasajeros"
        : "pasajero";
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
          child: Icon(Icons.train_outlined, color: colors.onPrimaryContainer),
        ),
        title: Text(
          "${_reserva.origen} → ${_reserva.destino}",
          style: TextStyle(
            color: colors.onSurface,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsetsGeometry.only(top: 6),
          child: Text(
            "${_reserva.fecha} - ${_reserva.hora} -  ${_reserva.pasajeros} $multiplePasajeros",
            style: TextStyle(color: colors.onSurfaceVariant, fontSize: 14),
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: colors.primary),
        onTap: () => id == null ? null : context.push('mis-reservas/$id'),
      ),
    );
  }
}
