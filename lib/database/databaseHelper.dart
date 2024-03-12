import 'package:sqflite/sqflite.dart';
import 'package:todo_list/model/todo.dart';

class DatabaseHelper {
  late final Database database;
  static const String _tableName = 'todo';

  DatabaseHelper(this.database);

  static Future<Database> initDB() async {
  final path = 'todo_database.db'; // Assuming the database file is in the root directory

  // Check if the database file exists
  bool exists = await databaseExists(path);

  if (!exists) {
    // If the database does not exist, create it and the table
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $_tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            content TEXT,
            importance INTEGER,
            isCompleted INTEGER
          )
        ''');
      },
      version: 1,
    );
  } else {
    // If the database already exists, return the existing database
    return openDatabase(path);
  }
}

  Future<void> insertTodo(Todo todo) async {
    Map<String, dynamic> map = {'content':todo.content,'importance':todo.importance, 'isCompleted':todo.isCompleted? 1 : 0};
    await database.insert(_tableName, map);
  }

  Future<List<Todo>> getAllTodos() async {
    final List<Map<String, dynamic>> maps = await database.query(_tableName);
    return List.generate(maps.length, (i) {
      bool isCompleted = intToBool(maps[i]['isCompleted']);
      return Todo(
        id: maps[i]['id'],
        content: maps[i]['content'],
        importance: maps[i]['importance'],
        isCompleted: isCompleted
      );
    });
  }

  Future<void> updateTodo(Todo todo) async {
    await database.update(
      _tableName,
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> deleteTodo(int id) async {
    await database.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  bool intToBool(int value) {
    return value == 1;
  }
}
