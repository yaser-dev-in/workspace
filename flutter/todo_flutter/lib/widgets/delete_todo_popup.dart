import 'package:flutter/material.dart';

import '../model/todo_model.dart';
import '../service/todo_service.dart';

class DeleteTodoPopup {
  static Future<bool> show(BuildContext context, TodoModel todoModel) async {
    TodoService todoService = TodoService();
    bool? isDeleted = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red),
              SizedBox(width: 8),
              Text('Delete Todo'),
            ],
          ),
          content: Text(
            'Are you sure you want to delete "${todoModel.title}"?',
          ),
          actions: [
            DeletePopupActions(
              onCancelPressed: () => Navigator.pop(dialogContext, false),
              onDeletePressed: () async {
                bool deleteResult = await todoService.deleteTodo(todoModel);
                Navigator.pop(dialogContext, deleteResult);
              },
            ),
          ],
        );
      },
    );
    return isDeleted ?? false;
  }
}

class DeletePopupActions extends StatelessWidget {
  VoidCallback onCancelPressed;
  VoidCallback onDeletePressed;

  DeletePopupActions({
    super.key,
    required this.onCancelPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          Expanded(child: CancelButton(onPressed: onCancelPressed)),
          const SizedBox(width: 12),
          Expanded(child: DeleteButton(onPressed: onDeletePressed)),
        ],
      ),
    );
  }
}

class CancelButton extends StatelessWidget {
  VoidCallback onPressed;

  CancelButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 48),
        foregroundColor: Theme.of(context).colorScheme.primary,
        side: BorderSide(color: Colors.grey.shade300),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: const Text('Cancel'),
    );
  }
}

class DeleteButton extends StatelessWidget {
  VoidCallback onPressed;

  DeleteButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        minimumSize: const Size(0, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: const Text('Delete'),
    );
  }
}
