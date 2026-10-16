import express from "express";

import connectDatabase from "./config/database";

import todoRoute from "./routes/todo_route";

const app = express();

app.use(express.json());

app.use(todoRoute);

connectDatabase();

app.listen(3000, () => {
  console.log("Server running on port 3000");
});
