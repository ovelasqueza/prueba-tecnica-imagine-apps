import 'package:flutter/material.dart';
import 'app_router.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión de Tareas',
      theme: ThemeData(primarySwatch: Colors.indigo),
      initialRoute: '/',
      onGenerateRoute: AppRouter.generateRoute, 
    );
  }
}