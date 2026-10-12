const mongoose = require("mongoose");

const todoSchema = new mongoose.Schema({
    id: Number,
    title: String,
    isCompleted: Boolean
});

const Todo = mongoose.model(
    "Todo",
    todoSchema
);

const createTodo = async (todo) => {
    return await Todo.create(todo);
};

const getTodo = async () => {
    return await Todo.find();
};

const updateTodo = async (
    id,
    todo
) => {
    return await Todo.findOneAndUpdate(
        { id: Number(id) },
        todo,
        { new: true }
    );
};

const deleteTodo = async (id) => {
    return await Todo.findOneAndDelete({
        id: Number(id)
    });
};

module.exports = {
    createTodo,
    getTodo,
    updateTodo,
    deleteTodo
};