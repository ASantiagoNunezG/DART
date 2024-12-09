// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

Future<List<User>> fetchUsers() async {
  final url = Uri.parse('https://reqres.in/api/users?page=1');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body)['data'];
    return data.map((userJson) => User.fromJson(userJson)).toList();
  } else {
    throw Exception('Error al obtener usuarios');
  }
}

Future<void> createUser(String firstName, String lastName, String email) async {
  final url = Uri.parse('https://reqres.in/api/users');
  final body = json.encode({
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
  });

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
