const mongoose = require("mongoose");

const connectDatabase = async () => {
    try {
        await mongoose.connect(
            "mongodb://localhost:27017/todo_db"
        );

        console.log(
            "MongoDB Connected"
        );
    }
    catch (error) {
        console.log(error);
    }
};

module.exports = connectDatabase;