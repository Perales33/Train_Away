import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:train_away/models/reserva_model.dart';
import 'package:train_away/providers/last_train_provider.dart';

Future<void> reiniciarReserva(BuildContext context) async {
  final reserva = context.read<ReservaModel>();
  final lastTrain = context.read<LastTrainProvider>();

  await lastTrain.charge();

  if(!context.mounted) { return; }

  const defaultOrigen = 'Estación de Almería';
  const defaultDestino = 'Estación de Cádiz';

  final origen = lastTrain.origen ?? defaultOrigen;
  final destinoGuardado = lastTrain.destino;

  final destino = destinoGuardado != null && destinoGuardado != origen ? destinoGuardado : defaultDestino;

  reserva.resetReserva(origen: origen, destino: destino);
  context.go('/reservar');
}