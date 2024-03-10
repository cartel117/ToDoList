import 'package:flutter/material.dart';
import 'package:todo_list/database/databaseHelper%20.dart';
import 'package:todo_list/model/todo.dart';

class ToDoListViewModel extends ChangeNotifier{
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
    );

    await DatabaseHelper.insertTodo(todo);
    await loadAllTodos();
    // notifyListeners();
  }

  Future<void> loadAllTodos() async {
    List<Todo> allTodoList = await DatabaseHelper.getAllTodos();
    // print('allTodoList count = ${allTodoList.length}');
    // for (int i = 0; i < allTodoList.length; i++){
    //   Todo todo = allTodoList[i];
    //   print('i = $i');
    //   print('todo id = ${todo.id}');
    //   print('todo content = ${todo.content}');
    //   print('todo importance = ${todo.importance}');
    // }
    setTodoList(allTodoList);
  }
}