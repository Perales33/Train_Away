import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:train_away/models/reserva.dart';

class ReservasDatabase {
  ReservasDatabase._();

  static final ReservasDatabase instance = ReservasDatabase._();

  static const String _nombreBD = 'train_away.db';
  static const String _tabla = 'reservas';
  Database? _db;

  static const sql = 
  'CREATE TABLE $_tabla ('
    'id INTEGER PRIMARY KEY AUTOINCREMENT,'
    'origen TEXT NOT NULL,'
    'destino TEXT NOT NULL,'
    'pasajeros INTEGER NOT NULL,'
    'categoria TEXT NOT NULL,'
    'opciones TEXT NOT NULL,'
    'fecha TEXT NOT NULL,'
    'hora TEXT NOT NULL'
  ')'; 

  Future<Database> get db async
  {
    return _db ??= await openDatabase(
      join(await getDatabasesPath(), _nombreBD),
      version: 1,
      onCreate: (db, version) async => db.execute(sql)
    );
  }

  Future<int> insertReserva(Reserva reserva) async =>
    (await db).insert(_tabla, reserva.toMap()..remove('id'));

  Future<List<Reserva>> selectReservas() async {
    final filas = await (await db).query(_tabla, orderBy: 'id DESC');
    return filas.map(Reserva.fromMap).toList();
  }

  Future<Reserva?> selectReserva(int id) async {
    final fila = await (await db).query(_tabla, where: 'id = ?', whereArgs: [id], limit: 1);
    if(fila.isEmpty) { return null; }
    return Reserva.fromMap(fila.first);
  }

  Future<int> deleteReserva(int id) async =>
    (await db).delete(_tabla, where: 'id = ?', whereArgs: [id]);

  Future<void> closeReservas() async {
    await (await db).close();
    _db = null;
  }
}