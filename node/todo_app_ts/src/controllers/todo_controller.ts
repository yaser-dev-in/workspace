import { Request, Response } from "express";
import TodoService from "../services/todo_service";

class TodoController extends TodoService {

  public async handleCreateTodoRequest(requestObject: Request, responseObject: Response): Promise<void> {
    console.log("Controller: Received POST /todo/create");
    try {
      const createdRecord = await this.createTodoServiceMethod(requestObject.body.todoData);
      responseObject.status(201).json(createdRecord);
    } catch (error) {
      console.error("Controller Error:", error);
      responseObject.status(500).json({ message: "Internal Server Error" });
    }
  }

  public async handleGetAllTodosRequest(requestObject: Request, responseObject: Response): Promise<void> {
    const extractedUserId = requestObject.body.userId; // Changed from query to body
    console.log("Controller: Received POST /todo/get-all for userId:", extractedUserId);
    try {
      const fetchedRecords = await this.getAllTodosServiceMethod(extractedUserId);
      responseObject.status(200).json(fetchedRecords);
    } catch (error) {
      console.error("Controller Error:", error);
      responseObject.status(500).json({ message: "Internal Server Error" });
    }
  }

  public async handleUpdateTodoRequest(requestObject: Request, responseObject: Response): Promise<void> {
    const extractedId = requestObject.body.todoData.id; // Changed from params to body
    const extractedUserId = requestObject.body.todoData.userId; // Changed from body.todo to body.todoData
    console.log("Controller: Received POST /todo/update for ID:", extractedId);
    try {
      const updatedRecord = await this.updateTodoServiceMethod(extractedId, extractedUserId, requestObject.body.todoData);
      responseObject.status(200).json(updatedRecord);
    } catch (error) {
      console.error("Controller Error:", error);
      responseObject.status(500).json({ message: "Internal Server Error" });
    }
  }

  public async handleDeleteTodoRequest(requestObject: Request, responseObject: Response): Promise<void> {
    const extractedId = requestObject.body.todoId; // Changed from params to body
    const extractedUserId = requestObject.body.userId; // Changed from query to body
    console.log("Controller: Received POST /todo/delete for ID:", extractedId);
    try {
      await this.deleteTodoServiceMethod(extractedId, extractedUserId);
      responseObject.status(200).json({ message: "Deleted successfully" });
    } catch (error) {
      console.error("Controller Error:", error);
      responseObject.status(500).json({ message: "Internal Server Error" });
    }
  }

  public async handleCompleteAllTodosRequest(requestObject: Request, responseObject: Response): Promise<void> {
    const extractedUserId = requestObject.body.userId;
    console.log("Controller: Received POST /todo/complete-all");
    try {
      await this.completeAllTodosServiceMethod(extractedUserId);
      responseObject.status(200).json({ message: "All completed" });
    } catch (error) {
      console.error("Controller Error:", error);
      responseObject.status(500).json({ message: "Internal Server Error" });
    }
  }

  public async handleDeleteAllTodosRequest(requestObject: Request, responseObject: Response): Promise<void> {
    const extractedUserId = requestObject.body.userId;
    console.log("Controller: Received POST /todo/delete-all");
    try {
      await this.deleteAllTodosServiceMethod(extractedUserId);
      responseObject.status(200).json({ message: "All deleted" });
    } catch (error) {
      console.error("Controller Error:", error);
      responseObject.status(500).json({ message: "Internal Server Error" });
    }
  }
}

export default TodoController;