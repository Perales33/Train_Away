import 'package:flutter/foundation.dart';

// import 'package:train_away/data/reservas_database.dart';
import 'package:train_away/models/reserva.dart';

class ReservasProvider extends ChangeNotifier {
  ReservasProvider(this._db);

  final /*ReservaDatabase*/ _db;

  List<Reserva> _reservas = [];
  bool _cargando = false;
  String? _error;

  List<Reserva> get reservas => List.unmodifiable(_reservas);
  bool get cargando => _cargando;
  String? get error => _error;

  Future<void> chargeReservas() async {
    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      _reservas = await _db.selectReservas();
    }
    catch (e) {
      _error = 'No se pudieron cargar las reservas';
    }
    finally {
      _cargando = false;
      notifyListeners();
    }
  }

  Future<Reserva> saveReserva(Reserva reserva) async {
    final id = await _db.insertReserva(reserva);
    final savedReserva = Reserva(
      id: id,
      origen: reserva.origen, 
      destino: reserva.destino, 
      pasajeros: reserva.pasajeros, 
      categoria: reserva.categoria, 
      opciones: reserva.opciones, 
      fecha: reserva.fecha, 
      hora: reserva.hora
    );

    _reservas = [savedReserva, ..._reservas];
    notifyListeners();

    return savedReserva;
  }

  Future<Reserva?> selectReserva(int id){
    return _db.selectReserva(id);
  }

  Future<void> deleteReserva(int id) async
  {
    await _db.deleteReserva(id);
    _reservas = _reservas.where((reserva) => reserva.id != id).toList();
    notifyListeners();
  }
}