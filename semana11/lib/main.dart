import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _useMaterial = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Material vs Cupertino"),
        actions: [
          Switch(
            value: _useMaterial,
            onChanged: (value) {
              setState(() {
                _useMaterial = value;
              });
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _useMaterial ? "MATERIAL" : "CUPERTINO",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: _useMaterial ? MaterialWidgetScreen() : CupertinoWidgetScreen()),
        ],
      ),
    );
  }
}

class MaterialWidgetScreen extends StatefulWidget {
  @override
  _MaterialWidgetScreenState createState() => _MaterialWidgetScreenState();
}

class _MaterialWidgetScreenState extends State<MaterialWidgetScreen> {
  double _sliderValue = 50;
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _story = '';
  String _imageUrl = '';
  List<Map<String, dynamic>> _storiesList = [
    {
      'title': 'El Silbón',
      'story': 'El Silbón es una leyenda que narra sobre el alma de un hombre...',
      'imageUrl': 'https://tucuentofavorito.com/wp-content/uploads/2020/06/silbon.jpg',
      'intensity': 80,
    },
    {
      'title': 'La Llorona',
      'story': 'La Llorona es una leyenda que cuenta la historia de una mujer...',
      'imageUrl': 'https://www.ciudadsanluis.com/leyendas/la-llorona/la-llorona.jpg',
      'intensity': 90,
    },
    {
      'title': 'Kuchisake-Onna',
      'story': 'Kuchisake-Onna es un espíritu japonés que lleva una máscara...',
      'imageUrl': 'https://static.wikia.nocookie.net/leyenda/images/b/b1/La_mujer_con_la_boca_cortada.jpg/revision/latest?cb=20151128193714&path-prefix=es',
      'intensity': 85,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // **Formulario (Material)**
          Text("Ingresa una Historia de Terror", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Título de la Historia'),
                  onSaved: (value) => _title = value ?? '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa un título';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10), // Espacio entre campos
                TextFormField(
                  decoration: InputDecoration(labelText: 'Historia'),
                  onSaved: (value) => _story = value ?? '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa la historia';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10), // Espacio entre campos
                TextFormField(
                  decoration: InputDecoration(labelText: 'URL de la Imagen'),
                  onSaved: (value) => _imageUrl = value ?? '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa la URL de la imagen';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20), // Espacio antes del botón
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      setState(() {
                        _storiesList.add({
                          'title': _title,
                          'story': _story,
                          'imageUrl': _imageUrl,
                          'intensity': _sliderValue,
                        });
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Historia guardada')));
                    }
                  },
                  child: Text("Agregar Historia"),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),

          // **Slider de Intensidad (Material)**
          Text("Intensidad del Miedo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Slider(
            value: _sliderValue,
            min: 0,
            max: 100,
            divisions: 10,
            label: _sliderValue.round().toString(),
            onChanged: (value) {
              setState(() {
                _sliderValue = value;
              });
            },
          ),
          SizedBox(height: 30),

          // **Lista de Historias (Material)**
          Text("Historias de Terror", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ListView(
            shrinkWrap: true,
            children: _storiesList.map((story) {
              return ListTile(
                title: Text(story['title']),
                subtitle: Text(story['story']),
                leading: Image.network(
                  story['imageUrl'],
                  width: 100, // Fijamos un tamaño fijo para la imagen
                  height: 100,
                  fit: BoxFit.cover,
                ),
                trailing: Text('Intensidad: ${story['intensity']}'),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class CupertinoWidgetScreen extends StatefulWidget {
  @override
  _CupertinoWidgetScreenState createState() => _CupertinoWidgetScreenState();
}

class _CupertinoWidgetScreenState extends State<CupertinoWidgetScreen> {
  double _sliderValue = 50;
  final _titleController = TextEditingController();
  final _storyController = TextEditingController();
  final _imageUrlController = TextEditingController();
  List<Map<String, dynamic>> _storiesList = [
    {
      'title': 'El Silbón',
      'story': 'El Silbón es una leyenda que narra sobre el alma de un hombre...',
      'imageUrl': 'https://tucuentofavorito.com/wp-content/uploads/2020/06/silbon.jpg',
      'intensity': 80,
    },
    {
      'title': 'La Llorona',
      'story': 'La Llorona es una leyenda que cuenta la historia de una mujer...',
      'imageUrl': 'https://www.ciudadsanluis.com/leyendas/la-llorona/la-llorona.jpg',
      'intensity': 90,
    },
    {
      'title': 'Kuchisake-Onna',
      'story': 'Kuchisake-Onna es un espíritu japonés que lleva una máscara...',
      'imageUrl': 'https://static.wikia.nocookie.net/leyenda/images/b/b1/La_mujer_con_la_boca_cortada.jpg/revision/latest?cb=20151128193714&path-prefix=es',
      'intensity': 85,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // **Formulario (Cupertino)**
          Text("Ingresa una Historia de Terror", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          CupertinoFormSection(
            header: Text("Formulario de Historia de Terror"),
            children: [
              CupertinoTextFormFieldRow(
                controller: _titleController,
                placeholder: "Título de la Historia",
              ),
              SizedBox(height: 10), // Espacio entre campos
              CupertinoTextFormFieldRow(
                controller: _storyController,
                placeholder: "Historia",
              ),
              SizedBox(height: 10), // Espacio entre campos
              CupertinoTextFormFieldRow(
                controller: _imageUrlController,
                placeholder: "URL de la Imagen",
              ),
              SizedBox(height: 20), // Espacio antes del botón
              CupertinoButton(
                child: Text("Agregar Historia"),
                onPressed: () {
                  setState(() {
                    _storiesList.add({
                      'title': _titleController.text,
                      'story': _storyController.text,
                      'imageUrl': _imageUrlController.text,
                      'intensity': _sliderValue,
                    });
                    _titleController.clear();
                    _storyController.clear();
                    _imageUrlController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Historia guardada')));
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 30),

          // **Slider de Intensidad (Cupertino)**
          Text("Intensidad del Miedo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          CupertinoSlider(
            value: _sliderValue,
            min: 0,
            max: 100,
            divisions: 10,
            onChanged: (value) {
              setState(() {
                _sliderValue = value;
              });
            },
          ),
          SizedBox(height: 30),

          // **Lista de Historias (Cupertino)**
          Text("Historias de Terror", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          CupertinoListSection.insetGrouped(
            children: _storiesList.map((story) {
              return CupertinoListTile(
                title: Text(story['title']),
                subtitle: Text(story['story']),
                leading: Image.network(
                  story['imageUrl'],
                  width: 100, // Fijamos un tamaño fijo para la imagen
                  height: 100,
                  fit: BoxFit.cover,
                ),
                trailing: Text('Intensidad: ${story['intensity']}'),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
