import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/task.dart';

class ApiService {
  final String apiUrl = 'http://localhost:8000/api'; // 

  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('$apiUrl/users'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar usuarios');
    }
  }

  Future<User> registerUser(User user) async {
    final response = await http.post(
      Uri.parse('$apiUrl/users/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );
    if (response.statusCode == 201) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al registrar usuario');
    }
  }

  Future<List<Task>> getTasks({int? userId}) async {
    final url = userId != null ? '$apiUrl/tasks?user_id=$userId' : '$apiUrl/tasks';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar tareas');
    }
  }

  Future<Task> createTask(Task task) async {
    final response = await http.post(
      Uri.parse('$apiUrl/tasks'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson()),
    );
    if (response.statusCode == 201) {
      return Task.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al crear tarea');
    }
  }

  Future<Task> updateTask(int taskId, Task task) async {
    final response = await http.put(
      Uri.parse('$apiUrl/tasks/$taskId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson()),
    );
    if (response.statusCode == 200) {
      return Task.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al actualizar tarea');
    }
  }

  Future<void> deleteTask(int taskId) async {
    final response = await http.delete(Uri.parse('$apiUrl/tasks/$taskId'));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar tarea');
    }
  }
}