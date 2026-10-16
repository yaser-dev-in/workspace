"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ioDeleteTodo = exports.ioUpdateTodo = exports.ioGetTodo = exports.ioCreateTodo = void 0;
const todo_service_1 = require("../services/todo_service");
const ioCreateTodo = async (req, res) => {
    const result = await (0, todo_service_1.createTodoService)(req.body.todo);
    res.status(201).json(result);
};
exports.ioCreateTodo = ioCreateTodo;
const ioGetTodo = async (req, res) => {
    const result = await (0, todo_service_1.getTodoService)();
    res.status(200).json(result);
};
exports.ioGetTodo = ioGetTodo;
const ioUpdateTodo = async (req, res) => {
    const result = await (0, todo_service_1.updateTodoService)(Number(req.params.id), req.body.todo);
    res.status(200).json(result);
};
exports.ioUpdateTodo = ioUpdateTodo;
const ioDeleteTodo = async (req, res) => {
    const result = await (0, todo_service_1.deleteTodoService)(Number(req.params.id));
    res.status(200).json(result);
};
exports.ioDeleteTodo = ioDeleteTodo;
