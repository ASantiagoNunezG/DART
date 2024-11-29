import 'package:flutter/material.dart';
import '../utils/receta_database.dart';
import '../models/receta.dart';
import 'agregar_receta_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RecetaDatabase recetaDatabase = RecetaDatabase.instance;
  List<RecetaModel> recetas = [];
  RecetaModel? recetaSeleccionada;

  @override
  void initState() {
    super.initState();
    refreshRecetas();
  }

  // Obtener todas las recetas y actualizar la UI
  refreshRecetas() {
    recetaDatabase.readAll().then((value) {
      setState(() {
        recetas = value;
        recetaSeleccionada = null; // Reseteamos la receta seleccionada al refrescar
      });
    });
  }

  // Navegar a la vista de agregar/editar receta
  goToAgregarRecetaScreen({int? id}) async {
    // Si id es null, estamos agregando una receta nueva
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AgregarRecetaScreen(recetaId: id),
      ),
    );
    refreshRecetas();
  }

  // Eliminar receta con confirmación
  deleteReceta(int? recetaId) async {
    if (recetaId == null) return; // No hace nada si el id es nulo

    bool confirmar = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar Receta'),
          content: const Text('¿Estás seguro de que quieres eliminar esta receta?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
    
    if (confirmar) {
      await recetaDatabase.delete(recetaId);
      refreshRecetas(); // Refrescamos las recetas
    }
  }

  // Expande o colapsa la receta seleccionada
  toggleRecetaDetalle(RecetaModel receta) {
    setState(() {
      recetaSeleccionada = recetaSeleccionada == receta ? null : receta;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recetas"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: recetas.isEmpty
            ? const Text(
                'No hay recetas',
                style: TextStyle(fontSize: 20, color: Colors.black),
              )
            : ListView.builder(
                itemCount: recetas.length,
                itemBuilder: (context, index) {
                  final receta = recetas[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              receta.titulo,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Text('Dificultad: ${receta.dificultad}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => goToAgregarRecetaScreen(id: receta.id),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => deleteReceta(receta.id),
                                ),
                              ],
                            ),
                            onTap: () => toggleRecetaDetalle(receta),
                          ),
                          if (recetaSeleccionada == receta)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Descripción:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(receta.descripcion),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Ingredientes:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(receta.ingredientes),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Preparación:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(receta.preparacion),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Tiempo de Preparación:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text("${receta.tiempoPreparacion} minutos"),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => goToAgregarRecetaScreen(), // No se pasa id para agregar nueva receta
        tooltip: 'Agregar Receta',
        child: const Icon(Icons.add),
      ),
    );
  }
}
