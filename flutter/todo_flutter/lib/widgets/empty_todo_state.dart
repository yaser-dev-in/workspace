import 'package:flutter/material.dart';

class EmptyTodoState extends StatelessWidget {
  const EmptyTodoState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 120),
        Icon(
          Icons.task_alt,
          size: 96,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.35),
        ),
        const SizedBox(height: 16),
        const Text(
          'No Todos yet',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Text(
          'Tap the + button to add your first todo',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey.shade600),
        ),
      ],
    );
  }
}
