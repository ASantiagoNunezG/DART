import 'package:flutter/material.dart';
import '../utils/receta_database.dart';
import '../models/receta.dart';

class AgregarRecetaScreen extends StatefulWidget {
  final int? recetaId;

  const AgregarRecetaScreen({Key? key, this.recetaId}) : super(key: key);

  @override
  _AgregarRecetaScreenState createState() => _AgregarRecetaScreenState();
}

class _AgregarRecetaScreenState extends State<AgregarRecetaScreen> {
  RecetaDatabase recetaDatabase = RecetaDatabase.instance;
  late RecetaModel receta;
  bool isLoading = false;

  // Controladores para los campos del formulario
  TextEditingController tituloController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController ingredientesController = TextEditingController();
  TextEditingController preparacionController = TextEditingController();
  TextEditingController imagenController = TextEditingController();
  TextEditingController tiempoPreparacionController = TextEditingController();
  int dificultad = 1;

  @override
  void initState() {
    super.initState();
    if (widget.recetaId != null) {
      // Si es una receta existente, cargamos los detalles
      recetaDatabase.read(widget.recetaId!).then((value) {
        setState(() {
          receta = value;
          tituloController.text = receta.titulo;
          descripcionController.text = receta.descripcion;
          ingredientesController.text = receta.ingredientes;
          preparacionController.text = receta.preparacion;
          imagenController.text = receta.imagen ?? ' ';
          tiempoPreparacionController.text = receta.tiempoPreparacion.toString();
          dificultad = receta.dificultad;
        });
      });
    }
  }

  // Guardar o actualizar la receta
  saveReceta() {
    setState(() {
      isLoading = true;
    });
    final recetaModel = RecetaModel(
      id: widget.recetaId,
      titulo: tituloController.text,
      descripcion: descripcionController.text,
      ingredientes: ingredientesController.text,
      preparacion: preparacionController.text,
      imagen: imagenController.text.trim().isEmpty ? null : imagenController.text.trim(),
      dificultad: dificultad,
      tiempoPreparacion: int.parse(tiempoPreparacionController.text),
    );
    if (widget.recetaId == null) {
      recetaDatabase.create(recetaModel);
    } else {
      recetaDatabase.update(recetaModel);
    }
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recetaId == null ? "Agregar Receta" : "Editar Receta"),
        backgroundColor: Color(0xFF8E7D6E), // Mantener color marrón en la barra
        elevation: 6,
        toolbarHeight: 80,
        titleTextStyle: TextStyle(
          fontFamily: 'Courier', // Retro font
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.recetaId == null ? "¡Vamos a agregar una receta!" : "Edita tu receta",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6A4E23), 
                        fontFamily: 'Courier', 
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(tituloController, 'Título', Colors.black, Colors.white),
                    const SizedBox(height: 16),
                    _buildTextField(descripcionController, 'Descripción', Colors.black, Colors.white),
                    const SizedBox(height: 16),
                    _buildTextField(ingredientesController, 'Ingredientes', Colors.black, Colors.white),
                    const SizedBox(height: 16),
                    _buildTextField(preparacionController, 'Preparación', Colors.black, Colors.white),
                    const SizedBox(height: 16),
                    _buildTextField(imagenController, 'Imagen (opcional)', Colors.black, Colors.white),
                    const SizedBox(height: 16),
                    _buildTextField(tiempoPreparacionController, 'Tiempo de preparación', Colors.black, Colors.white, TextInputType.number),
                    const SizedBox(height: 16),
                    _buildDropdown(),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: saveReceta,
                      child: Text(
                        widget.recetaId == null ? "Guardar Receta" : "Actualizar Receta",
                        style: const TextStyle(
                          fontSize: 18,
                          decorationColor: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Color(0xFF8E7D6E), // Mantener el marrón
                        foregroundColor: Colors.white, 
                        shadowColor: Colors.black, // Agregar sombra para darle más profundidad
                        elevation: 5, // Elevar un poco más el botón
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  // Expandir
  Widget _buildTextField(TextEditingController controller, String label, Color textColor, Color fillColor, [TextInputType inputType = TextInputType.text]) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: textColor,
          fontFamily: 'Courier', 
        ),
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Dropdown para el nivel de dificultad
  Widget _buildDropdown() {
    return DropdownButton<int>(
      value: dificultad,
      dropdownColor: Colors.white, // Fondo blanco para el dropdown
      items: List.generate(5, (index) {
        return DropdownMenuItem(
          value: index + 1,
          child: Text(
            'Dificultad: ${index + 1}',
            style: TextStyle(color: Colors.black, fontFamily: 'Courier'),
          ),
        );
      }),
      onChanged: (value) {
        setState(() {
          dificultad = value!;
        });
      },
    );
  }
}
