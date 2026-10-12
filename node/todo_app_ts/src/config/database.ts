import mongoose from "mongoose";

const connectDatabase = async (): Promise<void> => {
    await mongoose.connect(
        "mongodb://mongo_db:27017/todo_db"
    );

    console.log(
        "MongoDB Connected"
    );
};

export default connectDatabase;