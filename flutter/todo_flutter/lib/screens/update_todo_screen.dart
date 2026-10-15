import 'package:flutter/material.dart';

import '../model/todo_model.dart';
import '../service/todo_service.dart';
import '../utils/snackbar_util.dart';

class UpdateTodoScreen extends StatefulWidget {
  TodoModel todoModel;

  UpdateTodoScreen({super.key, required this.todoModel});

  @override
  State<UpdateTodoScreen> createState() => _UpdateTodoScreenState();
}

class _UpdateTodoScreenState extends State<UpdateTodoScreen> {
  TodoService todoService = TodoService();
  TextEditingController titleController = TextEditingController();
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.todoModel.title;
    isCompleted = widget.todoModel.isCompleted;
  }

  Future<void> updateTodo() async {
    String title = titleController.text.trim();
    if (title.isEmpty) {
      SnackbarUtil.show(context, 'Title cannot be empty', Icons.error_outline);
      return;
    }
    TodoModel updatedTodo = TodoModel(
      id: widget.todoModel.id,
      title: title,
      isCompleted: isCompleted,
      userId: widget.todoModel.userId,
    );
    TodoModel? result = await todoService.updateTodo(updatedTodo);
    if (result == null) {
      SnackbarUtil.show(
        context,
        'Update failed. Try again.',
        Icons.error_outline,
      );
      return;
    }
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Todo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                prefixIcon: Icon(Icons.edit_outlined),
              ),
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              value: isCompleted,
              onChanged: (value) =>
                  setState(() => isCompleted = value ?? false),
              title: const Text('Completed'),
              secondary: const Icon(Icons.check_circle_outline),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: updateTodo,
              icon: const Icon(Icons.update),
              label: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
