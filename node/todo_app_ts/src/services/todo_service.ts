import { createTodo, getTodo, updateTodo, deleteTodo } from "../models/todo_model";
import { ITodo } from "../interfaces/todo_interfaces";

const createTodoService = async (todo: ITodo) => {
  return await createTodo(todo);
};

const getTodoService = async (userId: string) => {
  return await getTodo(userId);
};

const updateTodoService = async (id: number, userId: string, todo: Partial<ITodo>) => {
  return await updateTodo(id, userId, todo);
};

const deleteTodoService = async (id: number, userId: string) => {
  return await deleteTodo(id, userId);
};

export { createTodoService, getTodoService, updateTodoService, deleteTodoService };