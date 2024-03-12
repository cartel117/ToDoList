import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/database/databaseHelper.dart';
import 'package:todo_list/model/todo.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'db_test.mocks.dart';

// 定义一个模拟数据库工厂
// class MockDatabaseFactory extends Mock implements sqflite.DatabaseFactory {}

@GenerateMocks([Database]) 
void main() {
  // sqfliteFfiInit();
   // Initialize databaseFactory for sqflite_common_ffi
  databaseFactory = databaseFactoryFfi;
  final mockDatabase = MockDatabase();

  test('insertTodo should insert a todo into the database', () async {
    DatabaseHelper dbhelper = DatabaseHelper(mockDatabase);
    final todo = Todo(
      id: 1,
      content: 'Test todo',
      importance: 1,
      isCompleted: false,
    );
    final expectedMap = {
      'content': todo.content,
      'importance': todo.importance,
      'isCompleted': todo.isCompleted ? 1 : 0,
    };

    // when(mockDatabase.insert('todo', todo.toMap()));
    when(mockDatabase.insert('todo', {'content':todo.content,'importance':todo.importance, 'isCompleted':todo.isCompleted? 1 : 0})).thenAnswer((_) async => 1);

    await dbhelper.insertTodo(todo);
    verify(mockDatabase.insert('todo', expectedMap)).called(1);
  });

  test('getAllTodos should return a list of todos from the database', () async {
    DatabaseHelper dbhelper = DatabaseHelper(mockDatabase);
    final expectedTodos = [
      Todo(
        id: 1,
        content: 'Test todo 1',
        importance: 1,
        isCompleted: false,
      ),
      Todo(
        id: 2,
        content: 'Test todo 2',
        importance: 2,
        isCompleted: true,
      ),
    ];
    final maps = [
      {'id': 1, 'content': 'Test todo 1', 'importance': 1, 'isCompleted': 0},
      {'id': 2, 'content': 'Test todo 2', 'importance': 2, 'isCompleted': 1},
    ];
    when(mockDatabase.query('todo')).thenAnswer((_) async => maps);

    final todos = await dbhelper.getAllTodos();

    expect(todos, isNotNull);
  });

  // Add tests for updateTodo and deleteTodo methods
}