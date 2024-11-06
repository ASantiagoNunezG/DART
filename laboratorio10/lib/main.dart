import 'package:flutter/material.dart';
import 'screens/movie_list.dart';

void main() {
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cartelera de Películas'),
        ),
        body: MovieList(),
      ),
    );
  }
}
