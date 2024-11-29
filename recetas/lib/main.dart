import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/receta_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecetaProvider(),
      child: MaterialApp(
        title: 'Recetas de Cocina',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
