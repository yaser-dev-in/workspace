import 'package:flutter/material.dart';

import '../model/todo_model.dart';
import '../screens/update_todo_screen.dart';
import '../utils/snackbar_util.dart';
import 'delete_todo_popup.dart';

class TodoItemCard extends StatelessWidget {
  TodoModel todoModel;
  VoidCallback onRefresh;
  void Function(TodoModel) onToggle;

  TodoItemCard({
    super.key,
    required this.todoModel,
    required this.onRefresh,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          TodoStatusIcon(todoModel: todoModel, onToggle: onToggle),
          const SizedBox(width: 12),
          TodoInformation(todoModel: todoModel),
          TodoMenuButton(todoModel: todoModel, onRefresh: onRefresh),
        ],
      ),
    );
  }
}

class TodoStatusIcon extends StatelessWidget {
  TodoModel todoModel;
  void Function(TodoModel) onToggle;

  TodoStatusIcon({super.key, required this.todoModel, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onToggle(todoModel),
      child: Icon(
        todoModel.isCompleted
            ? Icons.check_circle
            : Icons.radio_button_unchecked,
        color: todoModel.isCompleted ? Colors.green : Colors.grey.shade400,
        size: 28,
      ),
    );
  }
}

class TodoInformation extends StatelessWidget {
  TodoModel todoModel;

  TodoInformation({super.key, required this.todoModel});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TodoTitle(todoModel: todoModel),
          const SizedBox(height: 4),
          TodoStatusText(todoModel: todoModel),
        ],
      ),
    );
  }
}

class TodoTitle extends StatelessWidget {
  TodoModel todoModel;

  TodoTitle({super.key, required this.todoModel});

  @override
  Widget build(BuildContext context) {
    return Text(
      todoModel.title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        decoration: todoModel.isCompleted ? TextDecoration.lineThrough : null,
      ),
    );
  }
}

class TodoStatusText extends StatelessWidget {
  TodoModel todoModel;

  TodoStatusText({super.key, required this.todoModel});

  @override
  Widget build(BuildContext context) {
    return Text(
      todoModel.isCompleted ? 'Completed' : 'Pending',
      style: TextStyle(
        color: todoModel.isCompleted ? Colors.green : Colors.grey.shade600,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class TodoMenuButton extends StatelessWidget {
  TodoModel todoModel;
  VoidCallback onRefresh;

  TodoMenuButton({super.key, required this.todoModel, required this.onRefresh});

  Future<void> openUpdateScreen(BuildContext context) async {
    bool? isUpdated = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateTodoScreen(todoModel: todoModel),
      ),
    );
    if (isUpdated != true) return;
    onRefresh();
    SnackbarUtil.show(
      context,
      'Todo updated successfully',
      Icons.edit_outlined,
    );
  }

  Future<void> confirmDelete(BuildContext context) async {
    bool? isDeleted = await DeleteTodoPopup.show(context, todoModel);
    if (isDeleted != true) return;
    onRefresh();
    SnackbarUtil.show(
      context,
      'Todo deleted successfully',
      Icons.delete_outline,
    );
  }

  void handleMenuSelection(BuildContext context, String value) {
    if (value == 'update') openUpdateScreen(context);
    if (value == 'delete') confirmDelete(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) => handleMenuSelection(context, value),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'update',
          child: Row(
            children: [
              Icon(Icons.edit_outlined, size: 20),
              SizedBox(width: 10),
              Text('Update'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete_outline, size: 20, color: Colors.red),
              SizedBox(width: 10),
              Text('Delete', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
    );
  }
}
