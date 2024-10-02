// lib/widgets/curso_item.dart
import 'package:flutter/material.dart';
import '../models/curso.dart';

class CursoItem extends StatelessWidget {
  final Curso curso;

  @immutable
  CursoItem({required this.curso});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, 
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 13), 
      child: Padding(
        padding: const EdgeInsets.all(8.0), 
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Image.network(
                curso.imagenUrl,
                width: 230,
                height: 120, 
                fit: BoxFit.cover, 
              ),
            ),
            const SizedBox(width: 20), 
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  Text(
                    curso.nombre,
                    style:const  TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold, 
                    ),
                  ),
                  const SizedBox(height: 10), 
                  Text(
                    curso.descripcion,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700], 
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
