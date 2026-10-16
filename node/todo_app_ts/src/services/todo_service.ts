import TodoModel from "../models/todo_model";
import { ITodo } from "../interfaces/todo_interfaces";

class TodoService extends TodoModel {
  
  public async createTodoServiceMethod(todoData: ITodo): Promise<any> {
    console.log("Service Layer: Validating and passing to Model...");
    return await this.createDatabaseRecord(todoData);
  }

  public async getAllTodosServiceMethod(userId: string): Promise<any[]> {
    console.log("Service Layer: Requesting data from Model...");
    return await this.findAllRecordsByUserId(userId);
  }

  public async updateTodoServiceMethod(targetId: number, targetUserId: string, updatePayload: Partial<ITodo>): Promise<any> {
    console.log("Service Layer: Sending update payload to Model...");
    return await this.updateRecordById(targetId, targetUserId, updatePayload);
  }

  public async deleteTodoServiceMethod(targetId: number, targetUserId: string): Promise<any> {
    console.log("Service Layer: Sending delete request to Model...");
    return await this.deleteRecordById(targetId, targetUserId);
  }

  public async completeAllTodosServiceMethod(userId: string): Promise<any> {
    console.log("Service Layer: Sending complete-all to Model...");
    return await this.completeAllRecordsByUserId(userId);
  }

  public async deleteAllTodosServiceMethod(userId: string): Promise<any> {
    console.log("Service Layer: Sending delete-all to Model...");
    return await this.deleteAllRecordsByUserId(userId);
  }
}

export default TodoService;