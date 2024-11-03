import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detalle de Producto',
      theme: ThemeData(),
      home: ProductDetailScreen(),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del Producto
            Center(
              child: Image.asset(
                'assets/images/producto.jpg',
                width: 400,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            
            // Nombre del Producto
            Text(
              'Mantequilla de maní',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            
            // Precio del Producto
            Text(
              'S/. 9.99',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 10),
            
            // Descripción del Producto
            Text(
              'Mantequilla de maní, beneficioso para la salud, contiene proteínas y es un alimento muy bueno para acompañar desayunos.',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
