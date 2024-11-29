import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/receta.dart';
import '../providers/receta_provider.dart';

class AgregarRecetaScreen extends StatefulWidget {
  final Receta? receta;

  AgregarRecetaScreen({this.receta});

  @override
  _AgregarRecetaScreenState createState() => _AgregarRecetaScreenState();
}

class _AgregarRecetaScreenState extends State<AgregarRecetaScreen> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _ingredientesController = TextEditingController();
  final TextEditingController _preparacionController = TextEditingController();
  int _dificultad = 3;
  int _tiempoPreparacion = 30;
  XFile? _imagen;

  @override
  void initState() {
    super.initState();
    if (widget.receta != null) {
      _tituloController.text = widget.receta!.titulo;
      _descripcionController.text = widget.receta!.descripcion;
      _ingredientesController.text = widget.receta!.ingredientes;
      _preparacionController.text = widget.receta!.preparacion;
      _dificultad = widget.receta!.dificultad;
      _tiempoPreparacion = widget.receta!.tiempoPreparacion;
      _imagen = XFile(widget.receta!.imagen);
    }
  }

  void _seleccionarImagen() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagenSeleccionada = await picker.pickImage(source: ImageSource.gallery);
    if (imagenSeleccionada != null) {
      setState(() {
        _imagen = imagenSeleccionada;
      });
    }
  }

  void _guardarReceta() {
    if (_tituloController.text.isEmpty || _descripcionController.text.isEmpty) {
      return;
    }

    final nuevaReceta = Receta(
      id: widget.receta?.id ?? DateTime.now().millisecondsSinceEpoch,   // Si es una receta nueva, el ID será nulo.
      titulo: _tituloController.text,
      descripcion: _descripcionController.text,
      ingredientes: _ingredientesController.text,
      preparacion: _preparacionController.text,
      dificultad: _dificultad,
      tiempoPreparacion: _tiempoPreparacion,
      imagen: _imagen?.path ?? '',
      fechaCreacion: DateTime.now().toString(),
    );

    if (widget.receta == null) {
      // Si es una receta nueva, la agregamos
      Provider.of<RecetaProvider>(context, listen: false).agregarReceta(nuevaReceta);
    } else {
      // Si estamos editando, actualizamos la receta existente
      Provider.of<RecetaProvider>(context, listen: false).editarReceta(nuevaReceta);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receta == null ? 'Agregar Receta' : 'Editar Receta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(controller: _tituloController, decoration: InputDecoration(labelText: 'Título')),
            TextField(controller: _descripcionController, decoration: InputDecoration(labelText: 'Descripción')),
            TextField(controller: _ingredientesController, decoration: InputDecoration(labelText: 'Ingredientes')),
            TextField(controller: _preparacionController, decoration: InputDecoration(labelText: 'Preparación')),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Dificultad: $_dificultad'),
                Slider(
                  value: _dificultad.toDouble(),
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: _dificultad.toString(),
                  onChanged: (val) {
                    setState(() {
                      _dificultad = val.toInt();
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Tiempo: $_tiempoPreparacion min'),
                Slider(
                  value: _tiempoPreparacion.toDouble(),
                  min: 10,
                  max: 120,
                  divisions: 11,
                  label: '$_tiempoPreparacion',
                  onChanged: (val) {
                    setState(() {
                      _tiempoPreparacion = val.toInt();
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            _imagen == null
                ? ElevatedButton(onPressed: _seleccionarImagen, child: Text('Seleccionar imagen'))
                : Image.file(File(_imagen!.path), width: 100, height: 100),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _guardarReceta, child: Text(widget.receta == null ? 'Guardar Receta' : 'Guardar Cambios')),
          ],
        ),
      ),
    );
  }
}
