import mongoose from "mongoose";

class TodoRecord {
  protected todoDatabaseModel: any;

  constructor() {
    const todoSchema = new mongoose.Schema({
      id: Number,
      title: String,
      isCompleted: Boolean,
      userId: String
    });
    
    // 'Todo' is the collection name in MongoDB
    this.todoDatabaseModel = mongoose.model("Todo", todoSchema);
  }
}

export default TodoRecord;