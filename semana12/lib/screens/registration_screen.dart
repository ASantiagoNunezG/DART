import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'user_list_screen.dart';
import '../../models/user.dart';

class RegistrationScreen extends StatefulWidget {
  final bool useCupertino;

  const RegistrationScreen({super.key, required this.useCupertino});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final List<User> _registeredUsers = [];

  void _registerUser() {
    setState(() {
      _registeredUsers.add(
        User(
          username: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
      _usernameController.clear();
      _emailController.clear();
      _passwordController.clear();
    });
  }

  void _goToUserList() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            UserListScreen(users: _registeredUsers, useCupertino: widget.useCupertino),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.useCupertino
        ? CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(middle: Text('Registro')),
            child: Container(
              color: const Color(0xFFB3E5FC), // Fondo celeste
              child: Center(child: _buildFormCupertino()),
            ),
          )
        : Scaffold(
            appBar: AppBar(title: const Text('Registro')),
            body: Container(
              color: const Color(0xFFB3E5FC), // Fondo celeste
              child: Center(child: _buildFormMaterial()),
            ),
          );
  }

  Widget _buildFormMaterial() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Título y subtexto
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: const [
              Text(
                'Registro',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Lea detenidamente y complete los datos',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
        // Cuadro de registro
        Container(
          width: 350,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de Usuario',
                  hintText: 'Ingresa tu nombre de usuario',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo Electrónico',
                  hintText: 'Ingresa tu correo',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  hintText: 'Crea una contraseña segura',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _registerUser,
                child: const Text('Registrarse'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Botón "Ver Usuarios" fuera del cuadro
        TextButton(
          onPressed: _goToUserList,
          child: const Text('Ver Usuarios'),
        ),
      ],
    );
  }

  Widget _buildFormCupertino() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Título y subtexto
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: const [
              Text(
                'Registro',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Lea detenidamente y complete los datos',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
        // Cuadro de registro
        Container(
          width: 350,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              CupertinoTextField(
                controller: _usernameController,
                placeholder: 'Nombre de Usuario',
                padding: const EdgeInsets.all(16),
              ),
              const SizedBox(height: 16),
              CupertinoTextField(
                controller: _emailController,
                placeholder: 'Correo Electrónico',
                padding: const EdgeInsets.all(16),
              ),
              const SizedBox(height: 16),
              CupertinoTextField(
                controller: _passwordController,
                placeholder: 'Contraseña',
                obscureText: true,
                padding: const EdgeInsets.all(16),
              ),
              const SizedBox(height: 24),
              CupertinoButton.filled(
                onPressed: _registerUser,
                child: const Text('Registrarse'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Botón "Ver Usuarios" fuera del cuadro
        CupertinoButton(
          onPressed: _goToUserList,
          child: const Text('Ver Usuarios'),
        ),
      ],
    );
  }
}
