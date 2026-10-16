import TodoRecord from "./todo_record";
import { ITodo } from "../interfaces/todo_interfaces";

class TodoModel extends TodoRecord {
  
  public async createDatabaseRecord(todoData: ITodo): Promise<any> {
    console.log("Model Layer: Creating record for title:", todoData.title);
    return await this.todoDatabaseModel.create(todoData);
  }

  public async findAllRecordsByUserId(userId: string): Promise<any[]> {
    console.log("Model Layer: Finding records for userId:", userId);
    return await this.todoDatabaseModel.find({ userId: userId });
  }

  public async updateRecordById(targetId: number, targetUserId: string, updatePayload: Partial<ITodo>): Promise<any> {
    console.log("Model Layer: Updating record ID:", targetId);
    
    // SECURITY FIX: Prevent ID and UserId manipulation
    const safePayload = { ...updatePayload };
    delete safePayload.id;
    delete safePayload.userId;

    return await this.todoDatabaseModel.findOneAndUpdate(
      { id: targetId, userId: targetUserId },
      safePayload,
      { returnDocument: "after" }
    );
  }

  public async deleteRecordById(targetId: number, targetUserId: string): Promise<any> {
    console.log("Model Layer: Deleting record ID:", targetId);
    return await this.todoDatabaseModel.findOneAndDelete({ id: targetId, userId: targetUserId });
  }

  public async completeAllRecordsByUserId(userId: string): Promise<any> {
    console.log("Model Layer: Completing all records for userId:", userId);
    return await this.todoDatabaseModel.updateMany(
      { userId: userId, isCompleted: false },
      { isCompleted: true }
    );
  }

  public async deleteAllRecordsByUserId(userId: string): Promise<any> {
    console.log("Model Layer: Deleting all records for userId:", userId);
    return await this.todoDatabaseModel.deleteMany({ userId: userId });
  }
}

export default TodoModel;