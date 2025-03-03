import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskForm extends StatefulWidget {
  final Task? task; 
  final Function(String title, String description, String status) onSave;

  TaskForm({this.task, required this.onSave});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedStatus = 'pending';

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      titleController.text = widget.task!.title;
      descriptionController.text = widget.task!.description;
      selectedStatus = widget.task!.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: titleController,
          decoration: InputDecoration(labelText: 'Título'),
        ),
        TextField(
          controller: descriptionController,
          decoration: InputDecoration(labelText: 'Descripción'),
        ),
        DropdownButton<String>(
          value: selectedStatus,
          onChanged: (value) {
            setState(() {
              selectedStatus = value!;
            });
          },
          items: ['pending', 'completed', 'overdue']
              .map((status) => DropdownMenuItem(value: status, child: Text(status)))
              .toList(),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            final title = titleController.text;
            final description = descriptionController.text;

            if (title.isEmpty || description.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Por favor, completa todos los campos')),
              );
              return;
            }

            widget.onSave(title, description, selectedStatus);
          },
          child: Text(widget.task != null ? 'Actualizar Tarea' : 'Crear Tarea'),
        ),
      ],
    );
  }
}