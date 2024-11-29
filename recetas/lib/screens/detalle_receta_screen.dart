import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/receta.dart';
import '../providers/receta_provider.dart';
import '../screens/agregar_receta_screen.dart';

class DetalleRecetaScreen extends StatelessWidget {
  final Receta receta;

  DetalleRecetaScreen({required this.receta});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receta.titulo),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => AgregarRecetaScreen(receta: receta),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              // Mostrar un diálogo de confirmación antes de eliminar
              bool confirmDelete = await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('¿Estás seguro de eliminar esta receta?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text('Sí'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text('No'),
                      ),
                    ],
                  );
                },
              );

              if (confirmDelete) {
                // Llamar a eliminar receta en el provider
                Provider.of<RecetaProvider>(context, listen: false)
                    .eliminarReceta(receta.id);
                // Regresar a la pantalla principal (Home)
                Navigator.of(context).pop();  // Volver al Home
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(receta.titulo, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Descripción: ${receta.descripcion}'),
            SizedBox(height: 10),
            Text('Ingredientes: ${receta.ingredientes}'),
            SizedBox(height: 10),
            Text('Preparación: ${receta.preparacion}'),
            SizedBox(height: 10),
            Text('Dificultad: ${receta.dificultad}'),
            SizedBox(height: 10),
            Text('Tiempo de preparación: ${receta.tiempoPreparacion} min'),
            SizedBox(height: 10),
            receta.imagen.isNotEmpty
                ? Image.file(File(receta.imagen), width: 100, height: 100)
                : Container(),
          ],
        ),
      ),
    );
  }
}
