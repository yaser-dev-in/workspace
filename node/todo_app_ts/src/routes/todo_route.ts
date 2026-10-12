import express
from "express";

import {
    ioCreateTodo,
    ioGetTodo,
    ioUpdateTodo,
    ioDeleteTodo
}
from "../controllers/todo_controller";

const router =
    express.Router();

router.post(
    "/todo",
    ioCreateTodo
);

router.get(
    "/todo",
    ioGetTodo
);

router.put(
    "/todo/:id",
    ioUpdateTodo
);

router.delete(
    "/todo/:id",
    ioDeleteTodo
);

export default router;