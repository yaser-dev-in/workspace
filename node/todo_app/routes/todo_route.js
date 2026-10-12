const express = require("express");

const todoController = require(
    "../controllers/todo_controller"
);

const router = express.Router();

router.post("/", todoController.createTodo);

router.get("/", todoController.getTodo);

router.put("/:id", todoController.updateTodo);

router.delete("/:id", todoController.deleteTodo);

module.exports = router;