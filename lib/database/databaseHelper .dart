import 'package:sqflite/sqflite.dart';
import 'package:todo_list/model/todo.dart';

class DatabaseHelper {
  static Database? _database;
  static const String _tableName = 'todo';

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    return openDatabase(
      'todo_database.db',
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $_tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            content TEXT,
            importance INTEGER
          )
        ''');
      },
      version: 1,
    );
  }

  static Future<void> insertTodo(Todo todo) async {
    final db = await database;
    Map<String, dynamic> map = {'content':todo.content,'importance':todo.importance};
    await db.insert(_tableName, map);
  }

  static Future<List<Todo>> getAllTodos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    // print("maps -> $maps");
    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        content: maps[i]['content'],
        importance: maps[i]['importance'],
      );
    });
  }

  static Future<void> updateTodo(Todo todo) async {
    final db = await database;
    await db.update(
      _tableName,
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  static Future<void> deleteTodo(int id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
