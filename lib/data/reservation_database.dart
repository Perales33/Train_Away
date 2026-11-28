
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:train_away/models/clases_reserva/reserva.dart';

// Para acceder a bbdd de SQLite.
class ReservationDatabase {
  ReservationDatabase._();

  static final instance = ReservationDatabase._();

  Database? _databaseInstance;

  Future<Database> get _database async {
    return _databaseInstance ??= await _initDatabase();
  }

  // Iniciar bbdd local.
  Future<Database> _initDatabase() async {
    final rutaDataBase = await getDatabasesPath();
    final ruta = join(rutaDataBase, 'train_away.db');

    return openDatabase(
      ruta,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  // Crea la tabla de reservas
  Future<void> _createDatabase(
    Database db,
    int version,
  ) async {
    await db.execute('''
      CREATE TABLE reservas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        origen TEXT NOT NULL,
        destino TEXT NOT NULL,
        pasajeros INTEGER NOT NULL,
        categoria TEXT NOT NULL,
        opciones TEXT NOT NULL,
        fecha TEXT NOT NULL,
        hora TEXT NOT NULL
      )
    ''');
  }

  // Guardar una reserva confirmada
  Future<int> insertReserva(Reserva reserva) async {
    final db = await _database;
    final datos = reserva.toMap()..remove('id');

    return db.insert('reservas', datos);
  }

  // Obtener reservas confirmadas
  Future<List<Reserva>> selectReservas() async {
    final db = await _database;

    final resultado = await db.query(
      'reservas',
      orderBy: 'id DESC',
    );

    return resultado
        .map((fila) => Reserva.fromMap(fila))
        .toList();
  }

  // Obtener una reserva por su id
  Future<Reserva?> selectReserva(int id) async {
    final db = await _database;

    final resultado = await db.query(
      'reservas',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (resultado.isEmpty) {
      return null;
    }

    return Reserva.fromMap(resultado.first);
  }
}
