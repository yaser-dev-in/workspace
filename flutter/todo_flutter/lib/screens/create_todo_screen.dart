import 'package:flutter/material.dart';

import '../model/todo_model.dart';
import '../service/todo_service.dart';
import '../utils/snackbar_util.dart';

class CreateTodoScreen extends StatefulWidget {
  String userId;

  CreateTodoScreen({super.key, required this.userId});

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  TodoService todoService = TodoService();
  TextEditingController titleController = TextEditingController();

  Future<void> saveTodo() async {
    String title = titleController.text.trim();
    if (title.isEmpty) {
      SnackbarUtil.show(context, 'Title cannot be empty', Icons.error_outline);
      return;
    }
    TodoModel newTodo = TodoModel(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      isCompleted: false,
      userId: widget.userId,
    );
    TodoModel? createdTodo = await todoService.createTodo(newTodo);
    if (createdTodo == null) {
      SnackbarUtil.show(
        context,
        'Create failed. Try again.',
        Icons.error_outline,
      );
      return;
    }
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Todo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                prefixIcon: Icon(Icons.title),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: saveTodo,
              icon: const Icon(Icons.save),
              label: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
