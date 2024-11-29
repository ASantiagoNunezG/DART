import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/receta.dart';

class RecetaDatabase {
  static final RecetaDatabase instance = RecetaDatabase._internal();
  static Database? _database;

  RecetaDatabase._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'recetas.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, _) async {
    return await db.execute('''
      CREATE TABLE ${RecetaFields.tableName} (
        ${RecetaFields.id} ${RecetaFields.idType},
        ${RecetaFields.titulo} ${RecetaFields.textType},
        ${RecetaFields.descripcion} ${RecetaFields.textType},
        ${RecetaFields.ingredientes} ${RecetaFields.textType},
        ${RecetaFields.preparacion} ${RecetaFields.textType},
        ${RecetaFields.fechaCreacion} ${RecetaFields.textType},
        ${RecetaFields.imagen} TEXT,
        ${RecetaFields.dificultad} ${RecetaFields.intType},
        ${RecetaFields.tiempoPreparacion} ${RecetaFields.intType}
      )
    ''');
  }

  // Crear receta
  Future<RecetaModel> create(RecetaModel receta) async {
    final db = await instance.database;
    final id = await db.insert(RecetaFields.tableName, receta.toJson());
    return receta.copy(id: id);
  }

  // Leer receta por ID
  Future<RecetaModel> read(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      RecetaFields.tableName,
      columns: RecetaFields.values,
      where: '${RecetaFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return RecetaModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  // Leer todas las recetas
  Future<List<RecetaModel>> readAll() async {
    final db = await instance.database;
    final result = await db.query(RecetaFields.tableName);
    return result.map((json) => RecetaModel.fromJson(json)).toList();
  }

  // Actualizar receta
  Future<int> update(RecetaModel receta) async {
    final db = await instance.database;
    return db.update(
      RecetaFields.tableName,
      receta.toJson(),
      where: '${RecetaFields.id} = ?',
      whereArgs: [receta.id],
    );
  }

  // Eliminar receta
  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      RecetaFields.tableName,
      where: '${RecetaFields.id} = ?',
      whereArgs: [id],
    );
  }

  // Cerrar la base de datos
  Future close() async {
    final db = await instance.database;
    db.close();
  }
  

}
