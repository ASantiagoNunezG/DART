import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/receta.dart';

class DBHelper {
  static Database? _db;
  static const String RECETAS_TABLE = 'recetas';

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    var path = join(await getDatabasesPath(), 'recetas.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $RECETAS_TABLE (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT,
        descripcion TEXT,
        fecha_creacion TEXT,
        imagen TEXT,
        ingredientes TEXT,
        preparacion TEXT,
        dificultad INTEGER,
        tiempo_preparacion INTEGER
      )
    ''');
  }

  Future<int> insertarReceta(Receta receta) async {
    final dbClient = await db;
    return await dbClient.insert(RECETAS_TABLE, receta.toMap());
  }

  Future<List<Receta>> obtenerRecetas() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query(RECETAS_TABLE);
    return List.generate(maps.length, (i) {
      return Receta.fromMap(maps[i]);
    });
  }

  Future<int> actualizarReceta(Receta receta) async {
    final dbClient = await db;
    return await dbClient.update(
      RECETAS_TABLE,
      receta.toMap(),
      where: 'id = ?',
      whereArgs: [receta.id],
    );
  }

  Future<int> eliminarReceta(int id) async {
    final dbClient = await db;
    return await dbClient.delete(
      RECETAS_TABLE,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
