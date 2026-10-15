import 'package:flutter/material.dart';

import '../screens/create_todo_screen.dart';
import '../utils/snackbar_util.dart';

class TodoFab extends StatelessWidget {
  String userId;
  VoidCallback onRefresh;

  TodoFab({super.key, required this.userId, required this.onRefresh});

  Future<void> openCreateScreen(BuildContext context) async {
    bool? isCreated = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateTodoScreen(userId: userId)),
    );
    if (isCreated != true) return;
    onRefresh();
    SnackbarUtil.show(context, 'Todo created successfully', Icons.check_circle);
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => openCreateScreen(context),
      tooltip: 'Add Todo',
      child: const Icon(Icons.add),
    );
  }
}
