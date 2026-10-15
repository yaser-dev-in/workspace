import 'package:flutter/material.dart';

import '../model/todo_model.dart';
import '../service/todo_service.dart';
import '../service/user_service.dart';
import '../utils/snackbar_util.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/empty_todo_state.dart';
import '../widgets/todo_fab.dart';
import '../widgets/todo_item_card.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  TodoService todoService = TodoService();
  UserService userService = UserService();
  List<TodoModel> todoArray = [];
  bool isLoading = true;
  String userId = "";

  @override
  void initState() {
    super.initState();
    initUserAndLoad();
  }

  Future<void> initUserAndLoad() async {
    userId = await userService.getUserId();
    loadTodoArray();
  }

  Future<void> loadTodoArray() async {
    if (userId.isEmpty) return;
    List<TodoModel> fetchedArray = await todoService.getTodoArray(userId);
    if (!mounted) return;
    setState(() {
      todoArray = fetchedArray;
      isLoading = false;
    });
  }

  Future<void> toggleTodoStatus(TodoModel todoModel) async {
    bool newStatus = !todoModel.isCompleted;
    TodoModel updatedTodo = TodoModel(
      id: todoModel.id,
      title: todoModel.title,
      isCompleted: newStatus,
      userId: userId,
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
    loadTodoArray();
    String message = newStatus ? 'Marked as completed' : 'Marked as pending';
    SnackbarUtil.show(context, message, Icons.check_circle_outline);
  }

  Future<void> handleMenuAction(String action) async {
    if (userId.isEmpty) return;

    bool success = false;
    String successMessage = '';
    String errorMessage = '';

    if (action == 'complete_all') {
      success = await todoService.completeAllTodos(userId);
      successMessage = 'All tasks marked complete';
      errorMessage = 'Failed to complete all tasks';
    } else if (action == 'delete_all') {
      success = await todoService.deleteAllTodos(userId);
      successMessage = 'All tasks deleted';
      errorMessage = 'Failed to delete all tasks';
    }

    if (success && mounted) {
      loadTodoArray();
      SnackbarUtil.show(context, successMessage, Icons.check_circle);
    } else if (mounted) {
      SnackbarUtil.show(context, errorMessage, Icons.error_outline);
    }
  }

  Widget buildGradientBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Color(0xFF3F51B5), Color(0xFFE8EAF6)],
          stops: [0.0, 0.6],
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());

    // This pushes the content down below the AppBar
    double topPadding = MediaQuery.of(context).padding.top + kToolbarHeight;

    if (todoArray.isEmpty) {
      return RefreshIndicator(
        onRefresh: loadTodoArray,
        child: ListView(
          padding: EdgeInsets.only(top: topPadding),
          children: const [EmptyTodoState()],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: loadTodoArray,
      child: ListView(
        padding: EdgeInsets.only(top: topPadding, bottom: 8),
        children: [
          DashboardHeader(todoArray: todoArray),
          ...todoArray.map(
            (todoModel) => TodoItemCard(
              todoModel: todoModel,
              onRefresh: loadTodoArray,
              onToggle: toggleTodoStatus,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Keep this so gradient flows behind AppBar
      appBar: AppBar(
        title: const Text('My Todos'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: DropdownButton<String>(
              value: null,
              hint: const Text(
                'Actions',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              dropdownColor: Colors.white,
              underline: const SizedBox(),
              icon: const Icon(Icons.arrow_drop_down, size: 30),
              items: const [
                DropdownMenuItem(
                  value: 'complete_all',
                  child: Row(
                    children: [
                      Icon(Icons.done_all, size: 20, color: Colors.green),
                      SizedBox(width: 10),
                      Text('Mark all completed'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'delete_all',
                  child: Row(
                    children: [
                      Icon(Icons.delete_sweep, size: 20, color: Colors.red),
                      SizedBox(width: 10),
                      Text(
                        'Delete all tasks',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  handleMenuAction(value);
                }
              },
            ),
          ),
          IconButton(icon: const Icon(Icons.refresh), onPressed: loadTodoArray),
        ],
      ),
      body: Stack(children: [buildGradientBackground(), buildBody(context)]),
      floatingActionButton: TodoFab(userId: userId, onRefresh: loadTodoArray),
    );
  }
}
