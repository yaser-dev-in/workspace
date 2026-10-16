import { Router } from "express";
import TodoController from "../controllers/todo_controller";

class TodoRoutes extends TodoController {
  public router: Router;

  constructor() {
    super();
    this.router = Router();
    this.initializeRoutePaths();
  }

  private initializeRoutePaths(): void {
    // All routes are now POST requests with action-based URLs
    this.router.post("/todo/create", this.handleCreateTodoRequest.bind(this));
    this.router.post("/todo/get-all", this.handleGetAllTodosRequest.bind(this));
    this.router.post("/todo/update", this.handleUpdateTodoRequest.bind(this));
    this.router.post("/todo/delete", this.handleDeleteTodoRequest.bind(this));
    this.router.post("/todo/complete-all", this.handleCompleteAllTodosRequest.bind(this));
    this.router.post("/todo/delete-all", this.handleDeleteAllTodosRequest.bind(this));
  }
}

export default new TodoRoutes().router;