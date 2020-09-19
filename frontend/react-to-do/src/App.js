import React from 'react';
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
  const [value, setValue] = React.useState("");

  const handleSubmit = e => {
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
        onChange={e => setValue(e.target.value)}
      />
    </form>
  );
}

function App() {

  const API_URL = 'http://localhost:3000/'

  // const [recipes, setRecipes] = React.useState([]);
  const [hasError, setErrors] = React.useState(false);
  const [todos, setTodos] = React.useState([]);

  // const [planets, setPlanets] = useState({});

  async function fetchData() {
    const res = await fetch("http://localhost:3000/");
    res
      .json()
      .then(res => setTodos(res))
      .catch(err => setErrors(err));
  }

  React.useEffect(() => {
    fetchData();
  });

  const loadData = async () => {
    const response = await fetch(API_URL);
    const data = await response.json();
    setTodos(data.hits);
    console.log(data.hits);
  }

  const addTodo = text => {
    const newTodos = [...todos, { text }];
    setTodos(newTodos);
  };

  const completeTodo = index => {
    const newTodos = [...todos];
    newTodos[index].isCompleted = true;
    setTodos(newTodos);
  };

  const removeTodo = index => {
    const newTodos = [...todos];
    newTodos.splice(index, 1);
    setTodos(newTodos);
  };

  return (
    <div className="app">
      <div className="todo-list">
        {todos.map((todo, index) => (
          <Todo
            content={todo.content}
            id={todo.id}
            todo={todo.todo.content}
            completeTodo={completeTodo}
            removeTodo={removeTodo}
          />
        ))
        }
        {todos.map((todo,id) => (
          <TodoForm key={id} title={todo.content}/>
        ))}
        <span>{JSON.stringify(todos)}</span>
        <TodoForm addTodo={addTodo} />
      </div>
    </div>
  );
}

export default App;