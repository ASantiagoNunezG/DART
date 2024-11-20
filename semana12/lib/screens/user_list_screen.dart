import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/user.dart';

class UserListScreen extends StatelessWidget {
  final List<User> users;
  final bool useCupertino;

  const UserListScreen({super.key, required this.users, required this.useCupertino});

  @override
  Widget build(BuildContext context) {
    return useCupertino
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Usuarios Registrados'),
              trailing: CupertinoButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Volver'),
              ),
            ),
            child: _buildUserList(),
          )
        : Scaffold(
            appBar: AppBar(title: const Text('Usuarios Registrados')),
            body: _buildUserList(),
          );
  }

  Widget _buildUserList() {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(users[index].username),
          subtitle: Text(users[index].email),
        );
      },
    );
  }
}
