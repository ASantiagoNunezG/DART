// lib/screens/cursos_screen.dart
import 'package:flutter/material.dart';
import '../models/curso.dart';
import '../widgets/curso_item.dart';

class CursosScreen extends StatelessWidget {
  final List<Curso> cursos = [
    Curso(
      nombre: 'Flutter Básico',
      descripcion: 'Curso para principiantes en Flutter.',
      imagenUrl: 'https://codigofacilito.com/system/courses/thumbnails/000/000/364/original/3-_Curso_Profesional_de_Flutter.png?1637951368',
    ),
    Curso(
      nombre: 'Flutter Avanzado',
      descripcion: 'Curso para desarrolladores avanzados en Flutter.',
      imagenUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTG0MHVhSkKDaixahx5buV5Y-o7UKVrsRYgzw&s',
    ),
    Curso(
    nombre: 'Android con Kotlin',
    descripcion: 'Curso de desarrollo de aplicaciones móviles con Android y Kotlin.',
    imagenUrl: 'https://i.ytimg.com/vi/xKxta7MME44/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLCGxGMCIMGAQmMPFEICdrXZvfgZJw',
    ),
    Curso(
    nombre: 'Desarrollo de Apps con Swift',
    descripcion: 'Aprende a desarrollar aplicaciones para iOS usando Swift.',
    imagenUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3YZIiO07WeqQPrQk_smhi_H3ppugNouhJNMadYhwjNqa6H5mrJTP3SJQb2PVQ-zOuuro&usqp=CAU',
    ),
    Curso(
    nombre: 'Programación en Java',
    descripcion: 'Curso completo de programación orientada a objetos con Java.',
    imagenUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSO_R7fuUvS_8I8W_AUrCH-WGYMg1Xg954Jtw&s',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BootCamp-Nuñez Cursos'),
      ),
      body: ListView.builder(
        itemCount: cursos.length,
        itemBuilder: (context, index) {
          return CursoItem(curso: cursos[index]);
        },
      ),
    );
  }
}
