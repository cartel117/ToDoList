class Todo {
  int? id;
  final String content;
  final int importance;
  bool isCompleted;

  Todo({
    this.id,
    required this.content,
    required this.importance,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'importance': importance,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  static Todo fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] ?? -1,
      content: map['content'],
      importance: map['importance'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
}
