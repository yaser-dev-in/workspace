import {
    createTodo,
    getTodo,
    updateTodo,
    deleteTodo
}
from "../models/todo_model";

import {
    ITodo
}
from "../interfaces/todo_interfaces";

const createTodoService =
    async (
        todo: ITodo
    ) => {
        return await createTodo(
            todo
        );
    };

const getTodoService =
    async () => {
        return await getTodo();
    };

const updateTodoService =
    async (
        id: number,
        todo: Partial<ITodo>
    ) => {
        return await updateTodo(
            id,
            todo
        );
    };

const deleteTodoService =
    async (
        id: number
    ) => {
        return await deleteTodo(
            id
        );
    };

export {
    createTodoService,
    getTodoService,
    updateTodoService,
    deleteTodoService
};