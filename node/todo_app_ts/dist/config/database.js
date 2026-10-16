"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const mongoose_1 = __importDefault(require("mongoose"));
const connectDatabase = async () => {
    await mongoose_1.default.connect("mongodb://mongo_db:27017/todo_db");
    console.log("MongoDB Connected");
};
exports.default = connectDatabase;
