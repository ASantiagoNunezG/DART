// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

// Lista para simular datos locales
List<User> localUsers = [];

Future<List<User>> fetchUsers() async {
  final url = Uri.parse('https://reqres.in/api/users?page=1');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body)['data'];
    // Combina datos de la API con datos locales
    return [
      ...data.map((userJson) => User.fromJson(userJson)).toList(),
      ...localUsers
    ];
  } else {
    throw Exception('Error al obtener usuarios');
  }
}

Future<void> createUser(
    String firstName, String lastName, String email, String avatarUrl) async {
  // Simula la adición del usuario al array local
  final newUser = User(
    id: localUsers.length + 100, // ID único
    email: email,
    firstName: firstName,
    lastName: lastName,
    avatar: avatarUrl,
  );

  localUsers.add(newUser);
}
