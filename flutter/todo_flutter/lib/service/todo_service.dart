import 'package:dio/dio.dart';

import '../model/todo_model.dart';

class TodoService {
  Dio dio = Dio(BaseOptions(baseUrl: "http://64.227.163.157:3000"));
  String todoRoute = "/todo";

  Future<List<TodoModel>> getTodoArray(String userId) async {
    List<TodoModel> todoArray = [];
    try {
      Response response = await dio.get(
        todoRoute,
        queryParameters: {"userId": userId},
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

  Future<TodoModel?> createTodo(TodoModel todoModel) async {
    try {
      Response response = await dio.post(
        todoRoute,
        data: {"todo": todoModel.toJson()},
      );
      if (response.data == null) return null;
      return TodoModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (error) {
      return null;
    }
  }

  Future<TodoModel?> updateTodo(TodoModel todoModel) async {
    try {
      Response response = await dio.put(
        "$todoRoute/${todoModel.id}",
        data: {"todo": todoModel.toJson()},
      );
      if (response.data == null) return null;
      return TodoModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (error) {
      return null;
    }
  }

  Future<bool> deleteTodo(TodoModel todoModel) async {
    try {
      Response response = await dio.delete(
        "$todoRoute/${todoModel.id}",
        queryParameters: {"userId": todoModel.userId},
      );
      return response.statusCode == 200;
    } on DioException catch (error) {
      return false;
    }
  }

  Future<bool> completeAllTodos(String userId) async {
    try {
      Response response = await dio.put(
        "$todoRoute/complete-all",
        queryParameters: {"userId": userId},
      );
      return response.statusCode == 200;
    } on DioException catch (error) {
      return false;
    }
  }

  Future<bool> deleteAllTodos(String userId) async {
    try {
      Response response = await dio.delete(
        "$todoRoute/delete-all",
        queryParameters: {"userId": userId},
      );
      return response.statusCode == 200;
    } on DioException catch (error) {
      return false;
    }
  }
}
