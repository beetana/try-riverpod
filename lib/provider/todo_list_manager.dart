import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_tutorial/model/todo.dart';
import 'package:uuid/uuid.dart';

class TodoListManager extends StateNotifier<List<Todo>> {
  TodoListManager([List<Todo>? initialTodos]) : super(initialTodos ?? []);

  void add(String description) {
    var added = Todo(id: Uuid().v4(), description: description);
    state = [...state, added];
  }

  void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            description: todo.description,
            isCompleted: !todo.isCompleted,
          )
        else
          todo
    ];
  }

  void edit({required String id, required String newDescription}) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            description: newDescription,
            isCompleted: todo.isCompleted,
          )
        else
          todo
    ];
  }

  void delete(Todo deletedTodo) {
    state = state.where((todo) => todo.id != deletedTodo.id).toList();
  }

  int unCompletedTodoList() {
    return state.where((todo) => !todo.isCompleted).length;
  }
}
