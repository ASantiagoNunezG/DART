// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/cursos_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Cursos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CursosScreen(),
    );
  }
}
