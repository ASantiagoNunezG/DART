//lib/screens/user_list_screen.dart

import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import 'add_user_screen.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<User>> users;

  @override
  void initState() {
    super.initState();
    _refreshUsers();
  }

  void _refreshUsers() {
    setState(() {
      users = fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Usuarios')),
      body: FutureBuilder<List<User>>(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay usuarios disponibles'));
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                _refreshUsers();
              },
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final user = snapshot.data![index];
                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                  );
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddUserScreen()),
          );
          _refreshUsers();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
