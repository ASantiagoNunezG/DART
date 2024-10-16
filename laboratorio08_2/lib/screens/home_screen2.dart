import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String username;

  // Constructor para recibir el nombre de usuario
  HomeScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home2'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Center(
            child: Text(
              'BIENVENIDO OTRA VEZ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20), 
          Text(
            'Hola, $username',
            style: const TextStyle(fontSize: 20),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Volver a la pantalla de Login
                Navigator.pop(context);
              },
              child: const Text('Atrás'),
            ),
          ),
        ],
      ),
    );
  }
}
