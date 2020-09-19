import React, { useEffect, useState } from "react";
import "./App.css";

function Todo({ todo, index, completeTodo, removeTodo }) {
  return (
    <div
      className="todo"
      style={{ textDecoration: todo.isCompleted ? "line-through" : "" }}
    >
      {todo.text}
      <div>
        <button onClick={() => completeTodo(index)}>Complete</button>
        <button onClick={() => removeTodo(index)}>x</button>
      </div>
    </div>
  );
}

function TodoForm({ addTodo }) {
  const [value, setValue] = useState("");

  const handleSubmit = (e) => {
    e.preventDefault();
    if (!value) return;
    addTodo(value);
    setValue("");
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="text"
        className="input"
        value={value}
        onChange={(e) => setValue(e.target.value)}
      />
    </form>
  );
}

function App() {

  const [todos, setTodos] = useState([]);

  // const [planets, setPlanets] = useState({});
  const fetchData = async () => {
    const res = await fetch("http://localhost:3000/");
    console.log(res);
    return res;
  };

  // const loadData = async () => {
  //   const response = await fetch(API_URL);
  //   const data = await response.json();
  //   setTodos(data.hits);
  //   console.log(data.hits);
  // };

  const addTodo = (text) => {
    const newTodos = [...todos, { text }];
    setTodos(newTodos);
  };

  const getTodos = async (text) => {
    const newTodoList = await fetchData();
    console.log(newTodoList);
    setTodos(newTodoList.body);
  };

  const completeTodo = (index) => {
    const newTodos = [...todos];
    newTodos[index].isCompleted = true;
    setTodos(newTodos);
  };

  const removeTodo = (index) => {
    const newTodos = [...todos];
    newTodos.splice(index, 1);
    setTodos(newTodos);
  };

  return (
    <div className="app">
      <div className="todo-list">
        <h1>Todo List</h1>
        {[todos].map((todo, index) => (
          <Todo
            content={todo.content}
            id={todo.id}
            todo={todo.todo.content}
            completeTodo={completeTodo}
            removeTodo={removeTodo}
          />
        ))}
        <span>{JSON.stringify([todos])}</span>
        <button onClick={getTodos}>Fetch new TODOS</button>

        <TodoForm addTodo={addTodo} />
      </div>
    </div>
  );
}

export default App;