//lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

Future<List<User>> fetchUsers() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((userJson) => User.fromJson(userJson)).toList();
  } else {
    throw Exception('Error al obtener usuarios');
  }
}

Future<void> createUser(String name, String email) async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
  final body = json.encode({'name': name, 'email': email});

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: body,
  );

  if (response.statusCode == 201) {
    print('Usuario creado exitosamente');
  } else {
    throw Exception('Error al crear usuario');
  }
}
