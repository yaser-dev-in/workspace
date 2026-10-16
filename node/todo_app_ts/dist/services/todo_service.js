"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteTodoService = exports.updateTodoService = exports.getTodoService = exports.createTodoService = void 0;
const todo_model_1 = require("../models/todo_model");
const createTodoService = async (todo) => {
    return await (0, todo_model_1.createTodo)(todo);
};
exports.createTodoService = createTodoService;
const getTodoService = async () => {
    return await (0, todo_model_1.getTodo)();
};
exports.getTodoService = getTodoService;
const updateTodoService = async (id, todo) => {
    return await (0, todo_model_1.updateTodo)(id, todo);
};
exports.updateTodoService = updateTodoService;
const deleteTodoService = async (id) => {
    return await (0, todo_model_1.deleteTodo)(id);
};
exports.deleteTodoService = deleteTodoService;
