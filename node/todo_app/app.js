const connectDatabase =
    require("./config/database");

const express = require("express");

const todoRoute = require(
    "./routes/todo_route"
);

const app = express();

app.use(express.json());

app.use("/todo", todoRoute);

connectDatabase();

app.listen(3000, () => {
    console.log(
        "Server running on port 3000"
    );
});
``