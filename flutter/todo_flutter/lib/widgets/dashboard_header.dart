import 'package:flutter/material.dart';

import '../model/todo_model.dart';

class DashboardHeader extends StatelessWidget {
  List<TodoModel> todoArray;

  DashboardHeader({super.key, required this.todoArray});

  int getCompletedCount() {
    return todoArray.where((todoModel) => todoModel.isCompleted).length;
  }

  double getProgressRatio() {
    if (todoArray.isEmpty) return 0.0;
    return getCompletedCount() / todoArray.length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          DashboardImage(),
          const SizedBox(width: 16),
          Expanded(
            child: DashboardProgressInfo(
              completedCount: getCompletedCount(),
              totalCount: todoArray.length,
              progressRatio: getProgressRatio(),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/todo_list.png',
      height: 110,
      width: 110,
      fit: BoxFit.contain,
    );
  }
}

class DashboardProgressInfo extends StatelessWidget {
  int completedCount;
  int totalCount;
  double progressRatio;

  DashboardProgressInfo({
    super.key,
    required this.completedCount,
    required this.totalCount,
    required this.progressRatio,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'My Dashboard',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5C6BC0),
          ),
        ),
        const SizedBox(height: 12),
        ProgressTextRow(
          completedCount: completedCount,
          totalCount: totalCount,
          progressRatio: progressRatio,
        ),
        const SizedBox(height: 8),
        ProgressBarWidget(progressRatio: progressRatio),
      ],
    );
  }
}

class ProgressTextRow extends StatelessWidget {
  int completedCount;
  int totalCount;
  double progressRatio;

  ProgressTextRow({
    super.key,
    required this.completedCount,
    required this.totalCount,
    required this.progressRatio,
  });

  String getPercentageText() {
    return '${(progressRatio * 100).toStringAsFixed(0)}%';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Completed $completedCount out of $totalCount',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: Colors.black87,
          ),
        ),
        Text(
          getPercentageText(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Color(0xFF5C6BC0),
          ),
        ),
      ],
    );
  }
}

class ProgressBarWidget extends StatelessWidget {
  double progressRatio;

  ProgressBarWidget({super.key, required this.progressRatio});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: LinearProgressIndicator(
        value: progressRatio,
        minHeight: 10,
        backgroundColor: Colors.grey.shade200,
        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF5C6BC0)),
      ),
    );
  }
}
