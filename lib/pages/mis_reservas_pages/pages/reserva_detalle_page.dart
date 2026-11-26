import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';
import 'package:train_away/models/clases_reserva/reserva.dart';

import 'package:train_away/pages/mis_reservas_pages/widgets/detalle_reserva.dart';
import 'package:train_away/pages/mis_reservas_pages/widgets/mensaje_detalle.dart';
import 'package:train_away/providers/reservas_provider.dart';

class ReservaDetallePage extends StatefulWidget {
  const ReservaDetallePage({
    super.key,
    //required this._reserva
  });

  @override
  State<ReservaDetallePage> createState() => _ReservaDetallePageState();
}

class _ReservaDetallePageState extends State<ReservaDetallePage> {
  Future<Reserva?>? _reserva;
  String? _idError;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_reserva != null) return;
    final idText = GoRouterState.of(context).pathParameters['id'];
    final id = int.tryParse(idText ?? "");

    if (id == null) {
      _idError = "El identificador de la reserva no es válido";
      _reserva = Future<Reserva?>.value(null);
      return;
    }
    _reserva = context.read<ReservasProvider>().selectReserva(id);
  }

  @override
  Widget build(BuildContext context) {
    final future = _reserva;
    if (_idError != null) {
      return MensajeDetalle(mensaje: _idError!);
    }

    if (future == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const MensajeDetalle(mensaje: "No se pudo cargar la reserva");
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const MensajeDetalle(
            mensaje: 'No se encontró la reserva solicitada.',
          );
        }

        return DetalleReserva(reserva: snapshot.data!);
      },
    );
  }
}
