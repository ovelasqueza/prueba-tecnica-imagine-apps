import 'package:flutter/material.dart';
import '../repositories/user_repository.dart';
import '../widgets/user_registration_form.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserRegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository(ApiService()); 

    return Scaffold(
      appBar: AppBar(title: Text('Registrar Usuario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: UserRegistrationForm(
          onRegister: (name, email) async {
            try {
              await userRepository.registerUser(User(
                id: 0,
                name: name,
                email: email,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Usuario registrado con éxito')),
              );
              Navigator.pop(context); 
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error al registrar usuario: $e')),
              );
            }
          },
        ),
      ),
    );
  }
}