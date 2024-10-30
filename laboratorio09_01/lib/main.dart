import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Categorized List',
      theme: ThemeData(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    // Alimentos
    {
      'category': 'Alimentos',
      'name': 'Pizza',
      'image': 'assets/images/pizza.jfif',
      'fontFamily': 'OpenSans',
    },
    {
      'category': 'Alimentos',
      'name': 'Hamburguesa',
      'image': 'assets/images/burger.jfif',
      'fontFamily': 'OpenSans',
    },
    // Animales
    {
      'category': 'Animales',
      'name': 'Perro',
      'image': 'https://images.theconversation.com/files/625049/original/file-20241010-15-95v3ha.jpg?ixlib=rb-4.1.0&rect=4%2C12%2C2679%2C1521&q=20&auto=format&w=320&fit=clip&dpr=2&usm=12&cs=strip', // Imagen web
      'fontFamily': 'Lato',
    },
    {
      'category': 'Animales',
      'name': 'Gato',
      'image': 'assets/images/cat.jfif',
      'fontFamily': 'Lato',
    },
    // Lugares
    {
      'category': 'Lugares',
      'name': 'Montaña',
      'image': 'assets/images/mountain.jfif',
      'fontFamily': 'Ubuntu',
    },
    {
      'category': 'Lugares',
      'name': 'Playa',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTd4FkyudPfS3QiXDGAdEbGpl68JXC5sq9jmCwIrOoAVI4zm5o12Q0SHdBOHc-Gj0fvmg&usqp=CAU', // Imagen web
      'fontFamily': 'Ubuntu',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista Categorías')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            leading: item['image'].startsWith('http')
                ? Image.network(item['image'], width: 100, height: 100)
                : Image.asset(item['image'], width: 100, height: 100),
            title: Text(
              item['name'],
              style: TextStyle(fontFamily: item['fontFamily'], fontSize: 24),
            ),
            subtitle: Text(item['category']),
          );
        },
      ),
    );
  }
}
