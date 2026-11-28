import 'dart:convert';

class Reserva {
  const Reserva({
    this.id,
    required this.origen,
    required this.destino,
    required this.pasajeros,
    required this.categoria,
    required this.opciones,
    required this.fecha,
    required this.hora,
  });

  final int? id;
  final String origen;
  final String destino;
  final int pasajeros;
  final String categoria;
  final Map<String, bool> opciones;
  final DateTime fecha;
  final String hora;

  Map<String, Object?> toMap() => {
    'id': id,
    'origen': origen,
    'destino': destino,
    'pasajeros': pasajeros,
    'categoria': categoria,
    'opciones': jsonEncode(opciones),
    'fecha': fecha.toIso8601String(),
    'hora': hora,
  };

  factory Reserva.fromMap(Map<String, Object?> map) {
    final opcionesJson = map['opciones'] as String? ?? '{}';
    final opcionesDecoded = jsonDecode(opcionesJson) as Map<String, dynamic>;

    return Reserva(
      id: map['id'] as int?,
      origen: map['origen'] as String,
      destino: map['destino'] as String,
      pasajeros: map['pasajeros'] as int,
      categoria: map['categoria'] as String,
      opciones: opcionesDecoded.map(
        (key, value) => MapEntry(key, value as bool),
      ),
      fecha: DateTime.parse(map['fecha'] as String),
      hora: map['hora'] as String,
    );
  }

  String get formatDate {
    return "${fecha.day} de $_monthString de ${fecha.year}";
  }

  String get _monthString {
    switch (fecha.month) {
      case 1:
        {
          return "enero";
        }
      case 2:
        {
          return "febrero";
        }
      case 3:
        {
          return "marzo";
        }
      case 4:
        {
          return "abril";
        }
      case 5:
        {
          return "mayo";
        }
      case 6:
        {
          return "junio";
        }
      case 7:
        {
          return "julio";
        }
      case 8:
        {
          return "agosto";
        }
      case 9:
        {
          return "septiembre";
        }
      case 10:
        {
          return "octubre";
        }
      case 11:
        {
          return "noviembre";
        }
      case 12:
        {
          return "diciembre";
        }
      default:
        return "";
    }
  }
}
