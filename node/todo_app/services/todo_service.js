const todoModel = require(
    "../models/todo_model"
);

const createTodo = async (
    todo
) => {
    return await todoModel.createTodo(
        todo
    );
};

const getTodo = async () => {
    return await todoModel.getTodo();
};

const updateTodo = async (
    id,
    todo
) => {
    return await todoModel.updateTodo(
        id,
        todo
    );
};

const deleteTodo = async (id) => {
    return await todoModel.deleteTodo(
        id
    );
};

module.exports = {
    createTodo,
    getTodo,
    updateTodo,
    deleteTodo
};
``