import mongoose from "mongoose";

import {
    ITodo
}
from "../interfaces/todo_interfaces";

const todoSchema =
    new mongoose.Schema({
        id: Number,
        title: String,
        isCompleted: Boolean
    });

const Todo =
    mongoose.model(
        "Todo",
        todoSchema
    );

const createTodo =
    async (
        todo: ITodo
    ) => {
        return await Todo.create(
            todo
        );
    };

const getTodo =
    async () => {
        return await Todo.find();
    };

const updateTodo =
    async (
        id: number,
        todo: Partial<ITodo>
    ) => {
        return await Todo.findOneAndUpdate(
            { id },
            todo,
            { new: true }
        );
    };

const deleteTodo =
    async (
        id: number
    ) => {
        return await Todo.findOneAndDelete(
            { id }
        );
    };

export {
    createTodo,
    getTodo,
    updateTodo,
    deleteTodo
};