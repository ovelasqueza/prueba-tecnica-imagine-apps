import 'package:flutter/material.dart';
import '../models/user.dart';

class UserList extends StatelessWidget {
  final List<User> users;
  final Function(int userId) onUserTap;

  UserList({required this.users, required this.onUserTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          title: Text(user.name),
          subtitle: Text(user.email),
          onTap: () => onUserTap(user.id),
        );
      },
    );
  }
}