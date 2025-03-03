import 'package:flutter/material.dart';
import '../repositories/task_repository.dart';
import '../services/api_service.dart';
import '../utils/user_utils.dart';
import '../models/task.dart';
import '../models/user.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TaskRepository taskRepository;
  List<Task> tasks = [];
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    taskRepository = TaskRepository(ApiService()); 
    loadTasks();
    loadUsers();
  }

  Future<void> loadTasks() async {
    try {
      final fetchedTasks = await taskRepository.fetchTasks();
      if (mounted) {
        setState(() {
          tasks = fetchedTasks;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar tareas: $e')),
      );
    }
  }

  Future<void> loadUsers() async {
    try {
      final fetchedUsers = await ApiService().getUsers();
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

  Future<void> deleteTask(int taskId) async {
    try {
      await taskRepository.deleteTask(taskId);
      await loadTasks(); 
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tarea eliminada con éxito')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar tarea: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Tareas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/register_user'),
                  child: Text('Registrar Usuario'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/select_user'),
                  child: Text('Crear Tarea'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text('${task.description} - Pertenece a: ${getUserName(task.userId, users)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/create_task',
                            arguments: task,
                          ).then((_) => loadTasks());
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => deleteTask(task.id),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}