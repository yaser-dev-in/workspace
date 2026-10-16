"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteTodo = exports.updateTodo = exports.getTodo = exports.createTodo = void 0;
const mongoose_1 = __importDefault(require("mongoose"));
const todoSchema = new mongoose_1.default.Schema({
    id: Number,
    title: String,
    isCompleted: Boolean
});
const Todo = mongoose_1.default.model("Todo", todoSchema);
const createTodo = async (todo) => {
    return await Todo.create(todo);
};
exports.createTodo = createTodo;
const getTodo = async () => {
    return await Todo.find();
};
exports.getTodo = getTodo;
const updateTodo = async (id, todo) => {
    return await Todo.findOneAndUpdate({ id }, todo, { new: true });
};
exports.updateTodo = updateTodo;
const deleteTodo = async (id) => {
    return await Todo.findOneAndDelete({ id });
};
exports.deleteTodo = deleteTodo;
