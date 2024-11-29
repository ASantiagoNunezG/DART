class Receta {
  int id; // Este campo no puede ser nulo
  String titulo;
  String descripcion;
  String fechaCreacion;
  String imagen;
  String ingredientes;
  String preparacion;
  int dificultad;
  int tiempoPreparacion;

  Receta({
    required this.id,  // Usamos 'required' para asegurarnos de que siempre se pase un valor de id
    required this.titulo,
    required this.descripcion,
    required this.fechaCreacion,
    required this.imagen,
    required this.ingredientes,
    required this.preparacion,
    required this.dificultad,
    required this.tiempoPreparacion,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Asegúrate de incluir 'id' en el mapa
      'titulo': titulo,
      'descripcion': descripcion,
      'fecha_creacion': fechaCreacion,
      'imagen': imagen,
      'ingredientes': ingredientes,
      'preparacion': preparacion,
      'dificultad': dificultad,
      'tiempo_preparacion': tiempoPreparacion,
    };
  }

  factory Receta.fromMap(Map<String, dynamic> map) {
    return Receta(
      id: map['id'], // Asumimos que 'id' está siempre presente en el mapa
      titulo: map['titulo'],
      descripcion: map['descripcion'],
      fechaCreacion: map['fecha_creacion'],
      imagen: map['imagen'],
      ingredientes: map['ingredientes'],
      preparacion: map['preparacion'],
      dificultad: map['dificultad'],
      tiempoPreparacion: map['tiempo_preparacion'],
    );
  }
}
