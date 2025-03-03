import 'package:flutter/material.dart';
import '../repositories/user_repository.dart';
import '../widgets/user_list.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserSelectionScreen extends StatefulWidget {
  @override
  _UserSelectionScreenState createState() => _UserSelectionScreenState();
}

class _UserSelectionScreenState extends State<UserSelectionScreen> {
  late final UserRepository userRepository;
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    userRepository = UserRepository(ApiService()); 
    loadUsers();
  }

  Future<void> loadUsers() async {
    try {
      final fetchedUsers = await userRepository.getUsers();
      if (mounted) {
        setState(() {
          users = fetchedUsers;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar usuarios: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Seleccionar Usuario')),
      body: UserList(
        users: users,
        onUserTap: (userId) {
          Navigator.pushNamed(
            context,
            '/create_task',
            arguments: userId, 
          );
        },
      ),
    );
  }
}