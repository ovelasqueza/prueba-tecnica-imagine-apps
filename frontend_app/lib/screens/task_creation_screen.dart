import 'package:flutter/material.dart';
import '../repositories/task_repository.dart';
import '/widgets/task_form.dart';
import '../models/task.dart';
import '../services/api_service.dart';

class TaskCreationScreen extends StatelessWidget {
  final Task? task; 
  final int? userId; 

  TaskCreationScreen({this.task, this.userId});

  @override
  Widget build(BuildContext context) {
    final taskRepository = TaskRepository(ApiService());

    return Scaffold(
      appBar: AppBar(title: Text(task != null ? 'Editar Tarea' : 'Crear Tarea')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TaskForm(
          task: task,
          onSave: (title, description, status) async {
            try {
              if (task != null) {
                await taskRepository.updateTask(
                  task!.id,
                  Task(
                    id: task!.id,
                    userId: task!.userId,
                    title: title,
                    description: description,
                    status: status,
                    createdAt: task!.createdAt,
                    updatedAt: DateTime.now(),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tarea actualizada con éxito')),
                );
              } else {
                await taskRepository.createTask(
                  Task(
                    id: 0, 
                    userId: userId!,
                    title: title,
                    description: description,
                    status: status,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tarea creada con éxito')),
                );
              }
              Navigator.pop(context); 
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: $e')),
              );
            }
          },
        ),
      ),
    );
  }
}