class Todo {
  int? id;
  final String content;
  final int importance;

  Todo({
    this.id,
    required this.content,
    required this.importance,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'importance': importance,
    };
  }

  static Todo fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] ?? -1,
      content: map['content'],
      importance: map['importance'],
    );
  }
}
