// lib/screens/add_user_screen.dart

import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddUserScreen extends StatefulWidget {
  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _avatarUrl = '';

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await createUser(_firstName, _lastName, _email, _avatarUrl);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuario creado exitosamente')),
        );
        Navigator.pop(context); // Regresa a la lista
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear usuario: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Usuario',
            style: TextStyle(fontFamily: 'Lora', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.brown[100],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  labelStyle: TextStyle(fontFamily: 'Roboto'),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown[200]!)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre';
                  }
                  return null;
                },
                onSaved: (value) {
                  _firstName = value!;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Apellido',
                  labelStyle: TextStyle(fontFamily: 'Roboto'),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown[200]!)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un apellido';
                  }
                  return null;
                },
                onSaved: (value) {
                  _lastName = value!;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  labelStyle: TextStyle(fontFamily: 'Roboto'),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown[200]!)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un correo';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Por favor ingresa un correo válido';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'URL del Avatar',
                  labelStyle: TextStyle(fontFamily: 'Roboto'),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown[200]!)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una URL de avatar';
                  }
                  final uri = Uri.tryParse(value);
                  if (uri == null || !uri.hasAbsolutePath) {
                    return 'Por favor ingresa una URL válida';
                  }
                  return null;
                },
                onSaved: (value) {
                  _avatarUrl = value!;
                },
              ),
              SizedBox(height: 20),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Agregar Usuario',
                    style: TextStyle(fontFamily: 'PressStart2P')),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .brown[300], 
                      foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
