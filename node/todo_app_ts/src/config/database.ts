import mongoose from "mongoose";

const connectDatabase = async (): Promise<void> => {
    try {
        // Updated to match the new service name in docker-compose.yaml
        await mongoose.connect("mongodb://yaser_mongo_db:27017/todo_db");
        console.log("MongoDB Connected Successfully to yaser_mongo_db");
    } catch (error) {
        console.error("MongoDB Connection Failed:", error);
        process.exit(1); // Exit the process if the database connection fails
    }
};

export default connectDatabase;