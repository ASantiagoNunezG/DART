import 'package:flutter/material.dart';
import '../utils/receta_database.dart';
import '../models/receta.dart';

class AgregarRecetaScreen extends StatefulWidget {
  final int? recetaId;

  const AgregarRecetaScreen({Key? key, this.recetaId}) : super(key: key);

  @override
  _AgregarRecetaScreenState createState() => _AgregarRecetaScreenState();
}

class _AgregarRecetaScreenState extends State<AgregarRecetaScreen> {
  RecetaDatabase recetaDatabase = RecetaDatabase.instance;
  late RecetaModel receta;
  bool isLoading = false;

  // Controladores para los campos del formulario
  TextEditingController tituloController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController ingredientesController = TextEditingController();
  TextEditingController preparacionController = TextEditingController();
  TextEditingController imagenController = TextEditingController();
  TextEditingController tiempoPreparacionController = TextEditingController();
  int dificultad = 1;

  @override
  void initState() {
    super.initState();
    if (widget.recetaId != null) {
      // Si es una receta existente, cargamos los detalles
      recetaDatabase.read(widget.recetaId!).then((value) {
        setState(() {
          receta = value;
          tituloController.text = receta.titulo;
          descripcionController.text = receta.descripcion;
          ingredientesController.text = receta.ingredientes;
          preparacionController.text = receta.preparacion;
          imagenController.text = receta.imagen ?? '';
          tiempoPreparacionController.text = receta.tiempoPreparacion.toString();
          dificultad = receta.dificultad;
        });
      });
    }
  }

  // Guardar o actualizar la receta
  saveReceta() {
    setState(() {
      isLoading = true;
    });
    final recetaModel = RecetaModel(
      id: widget.recetaId,
      titulo: tituloController.text,
      descripcion: descripcionController.text,
      ingredientes: ingredientesController.text,
      preparacion: preparacionController.text,
      imagen: imagenController.text.isEmpty ? null : imagenController.text,
      dificultad: dificultad,
      tiempoPreparacion: int.parse(tiempoPreparacionController.text),
    );
    if (widget.recetaId == null) {
      recetaDatabase.create(recetaModel);
    } else {
      recetaDatabase.update(recetaModel);
    }
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recetaId == null ? "Agregar Receta" : "Editar Receta"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: tituloController,
                      decoration: const InputDecoration(labelText: 'Título'),
                    ),
                    TextField(
                      controller: descripcionController,
                      decoration: const InputDecoration(labelText: 'Descripción'),
                    ),
                    TextField(
                      controller: ingredientesController,
                      decoration: const InputDecoration(labelText: 'Ingredientes'),
                    ),
                    TextField(
                      controller: preparacionController,
                      decoration: const InputDecoration(labelText: 'Preparación'),
                    ),
                    TextField(
                      controller: imagenController,
                      decoration: const InputDecoration(labelText: 'Imagen (opcional)'),
                    ),
                    TextField(
                      controller: tiempoPreparacionController,
                      decoration: const InputDecoration(labelText: 'Tiempo de preparación'),
                      keyboardType: TextInputType.number,
                    ),
                    DropdownButton<int>(
                      value: dificultad,
                      items: List.generate(5, (index) {
                        return DropdownMenuItem(
                          value: index + 1,
                          child: Text('Dificultad: ${index + 1}'),
                        );
                      }),
                      onChanged: (value) {
                        setState(() {
                          dificultad = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: saveReceta,
                      child: Text(widget.recetaId == null ? "Guardar Receta" : "Actualizar Receta"),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
