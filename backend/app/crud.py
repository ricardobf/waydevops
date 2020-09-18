from sqlalchemy.orm import Session

from . import models, schemas


# this function will get all the todos
def get_todos(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.Todo).offset(skip).limit(limit).all()


# this function created a new todo from the data sent as input
def create_todo(db: Session, todo: schemas.TodoCreate):
    db_todo = models.Todo(content=todo.content)
    db.add(db_todo)
    db.commit()
    db.refresh(db_todo)
    return db_todo


# this function will update the todo
def update_todo(db: Session, todo_id: int, done: bool):
    db_todo = db.query(models.Todo).filter(models.Todo.id == todo_id).first()
    db_todo.done = done
    db.commit()
    db.refresh(db_todo)
    return db_todo