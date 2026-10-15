import 'package:flutter/material.dart';

import '../model/todo_model.dart';

class TodoProgressCard extends StatelessWidget {
  List<TodoModel> todoArray;

  TodoProgressCard({super.key, required this.todoArray});

  int calculateCompletedCount() {
    return todoArray.where((todoModel) => todoModel.isCompleted).length;
  }

  double calculateProgressRatio() {
    if (todoArray.isEmpty) return 0.0;
    return calculateCompletedCount() / todoArray.length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProgressHeader(
            completedCount: calculateCompletedCount(),
            totalCount: todoArray.length,
          ),
          const SizedBox(height: 12),
          ProgressIndicatorBar(progressRatio: calculateProgressRatio()),
        ],
      ),
    );
  }
}

class ProgressHeader extends StatelessWidget {
  int completedCount;
  int totalCount;

  ProgressHeader({
    super.key,
    required this.completedCount,
    required this.totalCount,
  });

  double calculatePercentage() {
    if (totalCount == 0) return 0.0;
    return (completedCount / totalCount) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.task_alt, size: 20, color: Colors.green),
            const SizedBox(width: 8),
            Text(
              'Completed $completedCount out of $totalCount',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ],
        ),
        Text(
          '${calculatePercentage().toStringAsFixed(0)}%',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}

class ProgressIndicatorBar extends StatelessWidget {
  double progressRatio;

  ProgressIndicatorBar({super.key, required this.progressRatio});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: progressRatio,
      minHeight: 10,
      borderRadius: BorderRadius.circular(6),
      backgroundColor: Colors.grey.shade200,
      valueColor: AlwaysStoppedAnimation<Color>(
        progressRatio >= 1.0
            ? Colors.green
            : Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
