import 'package:flutter/material.dart';
import '../models/receta.dart';

class RecetaProvider with ChangeNotifier {
  List<Receta> _recetas = [];

  List<Receta> get recetas => _recetas;

  void agregarReceta(Receta receta) {
    print('Receta agregada: ${receta.titulo}'); // Verifica que la receta se está agregando
    _recetas.add(receta);
    notifyListeners();
  }

  void eliminarReceta(int id) {
    print('Eliminando receta con ID: $id'); // Verifica que el ID es correcto
    _recetas.removeWhere((receta) => receta.id == id);
    notifyListeners();  // Notificamos a los listeners de la actualización
  }


  void editarReceta(Receta receta) {
    int index = _recetas.indexWhere((r) => r.id == receta.id);
    if (index != -1) {
      _recetas[index] = receta;  // Actualizar la receta en la lista
      notifyListeners();
    }
  }
}
