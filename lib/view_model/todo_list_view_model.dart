import 'package:flutter/material.dart';
import 'package:todo_list/database/databaseHelper.dart';
import 'package:todo_list/model/todo.dart';

class ToDoListViewModel extends ChangeNotifier {
  List<Todo> _todoList = [];
  List<Todo> get todoList => _todoList;

  ToDoListViewModel() {
    loadAllTodos();
  }

  void setTodoList(List<Todo> value) {
    _todoList = value;
    notifyListeners();
  }

  Future<void> addTodoToDatabase(String content, int importance) async {
    final todo = Todo(
        id: -1, // Assuming -1 means no data in the database
        content: content,
        importance: importance,
        isCompleted: false);
    
    final database = await DatabaseHelper.initDB();
    final dbHelper = DatabaseHelper(database);
    await dbHelper.insertTodo(todo);
    await loadAllTodos();
    // notifyListeners();
  }

  Future<void> loadAllTodos() async {
    final database = await DatabaseHelper.initDB();
    final dbHelper = DatabaseHelper(database);
    List<Todo> allTodoList = await dbHelper.getAllTodos();
    print('allTodoList count = ${allTodoList.length}');
    for (int i = 0; i < allTodoList.length; i++) {
      Todo todo = allTodoList[i];
      print('i = $i');
      print('todo id = ${todo.id}');
      print('todo content = ${todo.content}');
      print('todo importance = ${todo.importance}');
      print('todo isCompleted = ${todo.isCompleted}');
    }
    setTodoList(allTodoList);
  }

  Future<void> updateTodoInDatabase(Todo todo) async {
    final database = await DatabaseHelper.initDB();
    final dbHelper = DatabaseHelper(database);
    await dbHelper.updateTodo(todo);
    await loadAllTodos();
  }

  Future<void> deleteTodoFromDatabase(int id) async {
    final database = await DatabaseHelper.initDB();
    final dbHelper = DatabaseHelper(database);
    await dbHelper.deleteTodo(id);
    await loadAllTodos();
  }
}
