"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const database_1 = __importDefault(require("./config/database"));
const todo_route_1 = __importDefault(require("./routes/todo_route"));
const app = (0, express_1.default)();
app.use(express_1.default.json());
app.use(todo_route_1.default);
(0, database_1.default)();
app.listen(3000, () => {
    console.log("Server running on port 3000");
});
