class RecetaFields {
  static const List<String> values = [
    id,
    titulo,
    descripcion,
    ingredientes,
    preparacion,
    fechaCreacion,
    imagen,
    dificultad,
    tiempoPreparacion,
  ];

  static const String tableName = 'recetas';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT NOT NULL';
  static const String intType = 'INTEGER NOT NULL';

  static const String id = 'id';
  static const String titulo = 'titulo';
  static const String descripcion = 'descripcion';
  static const String ingredientes = 'ingredientes';
  static const String preparacion = 'preparacion';
  static const String fechaCreacion = 'fecha_creacion';
  static const String imagen = 'imagen';
  static const String dificultad = 'dificultad';
  static const String tiempoPreparacion = 'tiempo_preparacion';
}

class RecetaModel {
  int? id;
  final String titulo;
  final String descripcion;
  final String ingredientes;
  final String preparacion;
  final String fechaCreacion;
  final String? imagen;
  final int dificultad;
  final int tiempoPreparacion;

  RecetaModel({
    this.id,
    required this.titulo,
    required this.descripcion,
    required this.ingredientes,
    required this.preparacion,
    String? fechaCreacion,
    this.imagen,
    required this.dificultad,
    required this.tiempoPreparacion,
  }) : fechaCreacion = fechaCreacion ?? DateTime.now().toIso8601String();  // Usar la fecha y hora actuales


  // Convertir el modelo a un mapa
  Map<String, Object?> toJson() => {
        RecetaFields.id: id,
        RecetaFields.titulo: titulo,
        RecetaFields.descripcion: descripcion,
        RecetaFields.ingredientes: ingredientes,
        RecetaFields.preparacion: preparacion,
        RecetaFields.fechaCreacion: fechaCreacion,
        RecetaFields.imagen: imagen,
        RecetaFields.dificultad: dificultad,
        RecetaFields.tiempoPreparacion: tiempoPreparacion,
      };

  // Crear una receta desde un mapa
  factory RecetaModel.fromJson(Map<String, Object?> json) => RecetaModel(
        id: json[RecetaFields.id] as int?,
        titulo: json[RecetaFields.titulo] as String,
        descripcion: json[RecetaFields.descripcion] as String,
        ingredientes: json[RecetaFields.ingredientes] as String,
        preparacion: json[RecetaFields.preparacion] as String,
        fechaCreacion: json[RecetaFields.fechaCreacion] as String,
        imagen: json[RecetaFields.imagen] as String?,
        dificultad: json[RecetaFields.dificultad] as int,
        tiempoPreparacion: json[RecetaFields.tiempoPreparacion] as int,
      );

  // Copiar el modelo
  RecetaModel copy({
    int? id,
    String? titulo,
    String? descripcion,
    String? ingredientes,
    String? preparacion,
    String? fechaCreacion,
    String? imagen,
    int? dificultad,
    int? tiempoPreparacion,
  }) =>
      RecetaModel(
        id: id ?? this.id,
        titulo: titulo ?? this.titulo,
        descripcion: descripcion ?? this.descripcion,
        ingredientes: ingredientes ?? this.ingredientes,
        preparacion: preparacion ?? this.preparacion,
        fechaCreacion: fechaCreacion ?? this.fechaCreacion,
        imagen: imagen ?? this.imagen,
        dificultad: dificultad ?? this.dificultad,
        tiempoPreparacion: tiempoPreparacion ?? this.tiempoPreparacion,
      );
}
