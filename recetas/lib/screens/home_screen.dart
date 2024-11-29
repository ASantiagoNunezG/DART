import 'package:flutter/material.dart';
import '../utils/receta_database.dart';
import '../models/receta.dart';
import 'agregar_receta_screen.dart';
import 'package:intl/intl.dart';

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
        title: const Text("Recetas de Cocina"),
        backgroundColor: Color(0xFF8E7D6E), // Color marrón elegante
        elevation: 10,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Courier', // Retro font
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      body: Center(
        child: recetas.isEmpty
            ? const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'No hay recetas disponibles. ¡Añade algunas!',
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.builder(
                itemCount: recetas.length,
                itemBuilder: (context, index) {
                  final receta = recetas[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      color: Colors.orange.shade50, 
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), 
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.all(20), 
                            title: Text(
                              receta.titulo,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22, 
                                fontFamily: 'Courier',
                                color: Color(0xFF8E7D6E), 
                              ),
                            ),
                            subtitle: Text(
                              'Dificultad: ${receta.dificultad}',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.orange.shade800,
                                  fontStyle: FontStyle.italic),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.green),
                                  onPressed: () => goToAgregarRecetaScreen(id: receta.id),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => deleteReceta(receta.id),
                                ),
                              ],
                            ),
                            onTap: () => toggleRecetaDetalle(receta),
                          ),
                          if (recetaSeleccionada == receta)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Descripción:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: 'Courier'),
                                  ),
                                  Text(receta.descripcion),
                                  const SizedBox(height: 12), // Más espacio
                                  const Text(
                                    "Ingredientes:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: 'Courier'),
                                  ),
                                  Text(receta.ingredientes),
                                  const SizedBox(height: 12), 
                                  const Text(
                                    "Preparación:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: 'Courier'),
                                  ),
                                  Text(receta.preparacion),
                                  const SizedBox(height: 12), 
                                  const Text(
                                    "Tiempo de Preparación:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: 'Courier'),
                                  ),
                                  Text("${receta.tiempoPreparacion} minutos"),
                                  const SizedBox(height: 12), // Más espacio
                                  const Text(
                                    "Fecha del registro de la receta: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: 'Courier'),
                                  ),
                                  Text(DateFormat('HH:mm dd/MM/yyyy').format(DateTime.parse(receta.fechaCreacion))),
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
        backgroundColor: Color(0xFF8E7D6E), 
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
