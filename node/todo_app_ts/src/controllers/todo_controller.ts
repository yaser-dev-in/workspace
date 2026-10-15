import { Request, Response } from "express";
import {
  createTodoService,
  getTodoService,
  updateTodoService,
  deleteTodoService
} from "../services/todo_service";

const ioCreateTodo = async (req: Request, res: Response): Promise<void> => {
  const result = await createTodoService(req.body.todo);
  res.status(201).json(result);
};

const ioGetTodo = async (req: Request, res: Response): Promise<void> => {
  const userId = req.query.userId as string;
  const result = await getTodoService(userId);
  res.status(200).json(result);
};

const ioUpdateTodo = async (req: Request, res: Response): Promise<void> => {
  const result = await updateTodoService(
    Number(req.params.id),
    req.body.todo.userId,
    req.body.todo
  );
  res.status(200).json(result);
};

const ioDeleteTodo = async (req: Request, res: Response): Promise<void> => {
  const userId = req.query.userId as string;
  const result = await deleteTodoService(Number(req.params.id), userId);
  res.status(200).json(result);
};

export { ioCreateTodo, ioGetTodo, ioUpdateTodo, ioDeleteTodo };