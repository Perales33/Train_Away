import 'dart:convert';

class Reserva
{
  const Reserva({
    this.id,
    required this.origen,
    required this.destino,
    required this.pasajeros,
    required this.categoria,
    required this.opciones,
    required this.fecha,
    required this.hora
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
    'opciones': jsonEncode(opciones),
    'fecha': fecha.toIso8601String(),
    'hora': hora
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
      opciones: opcionesDecoded.map((key, value) => MapEntry(key, value as bool)),
      fecha: DateTime.parse(map['fecha'] as String), 
      hora: map['hora'] as String
    );
  }
}