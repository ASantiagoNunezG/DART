import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galería de Imágenes',
      theme: ThemeData(),
      home: ImageGalleryScreen(),
    );
  }
}

class ImageGalleryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Galería de Imágenes'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ImageItem(
            imagePath: 'assets/images/starcraft2.png',
            imageType: 'PNG',
            fontFamily: 'Arial',
          ),
          ImageItem(
            imagePath: 'assets/images/dota2.jpg',
            imageType: 'JPEG',
            fontFamily: 'TimesNewRoman',
          ),
          ImageItem(
            imagePath: 'assets/images/tecsup.svg',
            imageType: 'SVG',
            fontFamily: 'Roboto',
            isSvg: true,
          ),
        ],
      ),
    );
  }
}

class ImageItem extends StatelessWidget {
  final String imagePath;
  final String imageType;
  final String fontFamily;
  final bool isSvg;

  const ImageItem({
    required this.imagePath,
    required this.imageType,
    required this.fontFamily,
    this.isSvg = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          color: Colors.grey[200],
          child: isSvg
              ? SvgPicture.asset(
                  imagePath,
                  fit: BoxFit.contain,
                )
              : Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
        ),
        SizedBox(height: 8),
        Text(
          '$imageType Image',
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
