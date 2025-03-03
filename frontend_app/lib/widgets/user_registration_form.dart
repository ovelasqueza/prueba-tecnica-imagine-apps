import 'package:flutter/material.dart';

class UserRegistrationForm extends StatefulWidget {
  final Function(String name, String email) onRegister;

  UserRegistrationForm({required this.onRegister});

  @override
  _UserRegistrationFormState createState() => _UserRegistrationFormState();
}

class _UserRegistrationFormState extends State<UserRegistrationForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(labelText: 'Nombre'),
        ),
        TextField(
          controller: emailController,
          decoration: InputDecoration(labelText: 'Correo Electrónico'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            final name = nameController.text;
            final email = emailController.text;

            if (name.isEmpty || email.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Por favor, completa todos los campos')),
              );
              return;
            }

            widget.onRegister(name, email);
          },
          child: Text('Registrar Usuario'),
        ),
      ],
    );
  }
}