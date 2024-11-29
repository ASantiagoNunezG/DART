import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/receta_provider.dart';
import 'agregar_receta_screen.dart';
import 'detalle_receta_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recetas de Cocina'),
      ),
      body: Consumer<RecetaProvider>(
        builder: (ctx, recetaProvider, child) {
          final recetas = recetaProvider.recetas;

          return ListView.builder(
            itemCount: recetas.length,
            itemBuilder: (ctx, index) {
              final receta = recetas[index];
              return ListTile(
                contentPadding: EdgeInsets.all(8.0),
                leading: receta.imagen.isNotEmpty
                    ? Image.file(File(receta.imagen), width: 50, height: 50, fit: BoxFit.cover)
                    : Icon(Icons.fastfood, size: 50),
                title: Text(receta.titulo),
                subtitle: Text('Dificultad: ${receta.dificultad}'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => DetalleRecetaScreen(receta: receta),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => AgregarRecetaScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
