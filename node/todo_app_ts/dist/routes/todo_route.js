"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const todo_controller_1 = require("../controllers/todo_controller");
const router = express_1.default.Router();
router.post("/todo", todo_controller_1.ioCreateTodo);
router.get("/todo", todo_controller_1.ioGetTodo);
router.put("/todo/:id", todo_controller_1.ioUpdateTodo);
router.delete("/todo/:id", todo_controller_1.ioDeleteTodo);
exports.default = router;
