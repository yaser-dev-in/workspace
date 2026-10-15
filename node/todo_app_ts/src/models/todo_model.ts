import mongoose from "mongoose";
import { ITodo } from "../interfaces/todo_interfaces";

const todoSchema = new mongoose.Schema({
  id: Number,
  title: String,
  isCompleted: Boolean,
  userId: String
});

const Todo = mongoose.model("Todo", todoSchema);

const createTodo = async (todo: ITodo) => {
  return await Todo.create(todo);
};

const getTodo = async (userId: string) => {
  return await Todo.find({ userId });
};

const updateTodo = async (id: number, userId: string, todo: Partial<ITodo>) => {
  return await Todo.findOneAndUpdate(
    { id, userId }, // Security: ensure user only updates their own todo
    todo,
    { new: true }
  );
};

const deleteTodo = async (id: number, userId: string) => {
  return await Todo.findOneAndDelete({ id, userId });
};

export { createTodo, getTodo, updateTodo, deleteTodo };