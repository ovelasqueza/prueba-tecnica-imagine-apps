import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/user_registration_screen.dart';
import 'screens/user_selection_screen.dart';
import 'screens/task_creation_screen.dart';
import 'models/task.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/register_user':
        return MaterialPageRoute(builder: (_) => UserRegistrationScreen());
      case '/select_user':
        return MaterialPageRoute(builder: (_) => UserSelectionScreen());
      case '/create_task':
        final args = settings.arguments;
        if (args is int) {
         
          return MaterialPageRoute(
            builder: (_) => TaskCreationScreen(userId: args),
          );
        } else if (args is Task) {
         
          return MaterialPageRoute(
            builder: (_) => TaskCreationScreen(task: args),
          );
        }
        break;
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
    return MaterialPageRoute(builder: (_) => HomeScreen());
  }
}