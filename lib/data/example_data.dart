import 'package:train_away/models/clases_reserva/reserva.dart';

// Este archivo es de prueba para poder guardar los datos de forma local las reservas. Lo puedes eliminar Leslie

class ReservasMemoryDatabase {
  ReservasMemoryDatabase._();

  static final instance = ReservasMemoryDatabase._();

  final List<Reserva> _reservas = [];
  int _siguienteId = 1;

  Future<int> insertReserva(Reserva reserva) async {
    final id = _siguienteId++;

    _reservas.add(
      Reserva(
        id: id,
        origen: reserva.origen,
        destino: reserva.destino,
        pasajeros: reserva.pasajeros,
        categoria: reserva.categoria,
        opciones: Map<String, bool>.from(reserva.opciones),
        fecha: reserva.fecha,
        hora: reserva.hora,
      ),
    );

    return id;
  }

  Future<List<Reserva>> selectReservas() async {
    return List<Reserva>.unmodifiable(_reservas.reversed);
  }

  Future<Reserva?> selectReserva(int id) async {
    for (final reserva in _reservas) {
      if (reserva.id == id) return reserva;
    }
    return null;
  }

  Future<int> deleteReserva(int id) async {
    final cantidadAnterior = _reservas.length;
    _reservas.removeWhere((reserva) => reserva.id == id);
    return cantidadAnterior - _reservas.length;
  }
}