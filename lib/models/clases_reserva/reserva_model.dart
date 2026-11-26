import 'package:flutter/foundation.dart';

import 'reserva.dart';

class ReservaModel extends ChangeNotifier
{
  String _origen = '';
  String _destino = '';
  int _pasajeros = 1;
  String _categoria = '';
  Map<String, bool> _extras = {};
  DateTime? _fecha;
  String? _hora;

  String get origen => _origen;
  String get destino => _destino;
  int get pasajeros => _pasajeros;
  String get categoria => _categoria;
  Map<String, bool> get opciones => Map.unmodifiable(_extras);
  DateTime? get fecha => _fecha;
  String? get hora => _hora;

  void setTrayecto({
    required String origen,
    required String destino
  }) {
      _origen = origen;
      _destino = destino;
      notifyListeners();
  }

  void setOrigen(String origen) {
    _origen = origen;
    notifyListeners();
  }

  void setDestino (String destino) {
    _destino = destino;
    notifyListeners();
  }

  void setPasajeros(int pasajeros) { 
    _pasajeros = pasajeros;
    notifyListeners();
  }

  void setCategorias(String categoria) {
    _categoria = categoria;
    notifyListeners();
  }

  void setOpcion(String nombre, bool opcion) {
    _extras = {
      ..._extras,
      nombre: opcion,
    };
    notifyListeners();
  }

  void setOpciones(Map<String, bool> opciones) {
    _extras = Map<String, bool>.from(opciones);
    notifyListeners();
  }

  void setFecha(DateTime? fecha) {
    _fecha = fecha;
    notifyListeners();
  } 

  void setHora(String? hora) {
    _hora = hora;
    notifyListeners();
  }


  Reserva crearReserva()
  {
    final fechaSel = _fecha;
    final horaSel = _hora;

    if(_origen.isEmpty || _destino.isEmpty || _categoria.isEmpty || fechaSel == null || horaSel == null) {
      throw StateError('Faltan datos para la reserva');
    }

    return Reserva(
      origen: _origen, 
      destino: _destino, 
      pasajeros: _pasajeros, 
      categoria: _categoria, 
      opciones: Map<String, bool>.from(_extras), 
      fecha: fechaSel, 
      hora: horaSel
    );
  }

  void resetReserva({
    required String origen,
    required String destino
  }) {
    _origen = origen;
    _destino = destino;
    _pasajeros = 1;
    _categoria = '1ª Clase';
    _extras = { for (final nombre in _extras.keys) nombre: false };
    _fecha = null;
    _hora = null;
    notifyListeners();
  }
}