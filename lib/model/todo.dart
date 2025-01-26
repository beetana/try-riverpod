class Todo {
  final String id;
  final String description;
  final bool isCompleted;

  Todo({
    required this.id,
    required this.description,
    this.isCompleted = false,
  });
}
