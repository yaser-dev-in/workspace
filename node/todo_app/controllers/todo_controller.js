const todoService = require(
    "../services/todo_service"
);

const createTodo = async (
    req,
    res
) => {
    console.log(req.body);
    try {
        const result =
            await todoService.createTodo(
                req.body.todo
            );

        return res.status(201).json(
            result
        );
    }
    catch (error) {
        return res.status(500).json({
            message: error.message
        });
    }
};

const getTodo = async (
    req,
    res
) => {
    try {
        const result =
            await todoService.getTodo();

        return res.status(200).json(
            result
        );
    }
    catch (error) {
        return res.status(500).json({
            message: error.message
        });
    }
};

const updateTodo = async (
    req,
    res
) => {
    try {
        const result =
            await todoService.updateTodo(
                req.params.id,
                req.body.todo
            );

        if (!result) {
            return res.status(404).json({
                message: "Todo not found"
            });
        }

        return res.status(200).json(
            result
        );
    }
    catch (error) {
        return res.status(500).json({
            message: error.message
        });
    }
};

const deleteTodo = async (
    req,
    res
) => {
    try {
        const result =
            await todoService.deleteTodo(
                req.params.id
            );

        if (!result) {
            return res.status(404).json({
                message: "Todo not found"
            });
        }

        return res.status(200).json(
            result
        );
    }
    catch (error) {
        return res.status(500).json({
            message: error.message
        });
    }
};

module.exports = {
    createTodo,
    getTodo,
    updateTodo,
    deleteTodo
};