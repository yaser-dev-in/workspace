import 'package:dio/dio.dart';

import '../model/todo_model.dart';

class TodoService {
  // Ensure this matches your new docker-compose port (e.g., 3003)
  Dio dio = Dio(BaseOptions(baseUrl: "http://intern1.gpstrack.in:3000"));
  String todoRoute = "/todo";

  // 1. GET ALL -> NOW POST /todo/get-all
  Future<List<TodoModel>> getTodoArray(String userId) async {
    List<TodoModel> todoArray = [];
    try {
      Response response = await dio.post(
        "$todoRoute/get-all",
        data: {"userId": userId},
      );
      if (response.data == null) return todoArray;
      List<dynamic> dataArray = response.data as List<dynamic>;
      todoArray = dataArray
          .map((json) => TodoModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (error) {
      // Exception managed at top
    }
    return todoArray;
  }

  // 2. CREATE -> POST /todo/create
  Future<TodoModel?> createTodo(TodoModel todoModel) async {
    try {
      Response response = await dio.post(
        "$todoRoute/create",
        data: {"todoData": todoModel.toJson()},
      );
      if (response.data == null) return null;
      return TodoModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (error) {
      return null;
    }
  }

  // 3. UPDATE -> POST /todo/update
  Future<TodoModel?> updateTodo(TodoModel todoModel) async {
    try {
      Response response = await dio.post(
        "$todoRoute/update",
        data: {"todoData": todoModel.toJson()},
      );
      if (response.data == null) return null;
      return TodoModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (error) {
      return null;
    }
  }

  // 4. DELETE -> POST /todo/delete
  Future<bool> deleteTodo(TodoModel todoModel) async {
    try {
      Response response = await dio.post(
        "$todoRoute/delete",
        data: {"todoId": todoModel.id, "userId": todoModel.userId},
      );
      return response.statusCode == 200;
    } on DioException catch (error) {
      return false;
    }
  }

  // 5. COMPLETE ALL -> POST /todo/complete-all
  Future<bool> completeAllTodos(String userId) async {
    try {
      Response response = await dio.post(
        "$todoRoute/complete-all",
        data: {"userId": userId},
      );
      return response.statusCode == 200;
    } on DioException catch (error) {
      return false;
    }
  }

  // 6. DELETE ALL -> POST /todo/delete-all
  Future<bool> deleteAllTodos(String userId) async {
    try {
      Response response = await dio.post(
        "$todoRoute/delete-all",
        data: {"userId": userId},
      );
      return response.statusCode == 200;
    } on DioException catch (error) {
      return false;
    }
  }
}
