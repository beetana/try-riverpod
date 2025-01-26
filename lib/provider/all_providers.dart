import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_tutorial/model/todo.dart';
import 'package:riverpod_todo_tutorial/provider/todo_list_manager.dart';
import 'package:uuid/uuid.dart';

enum TodoListFilter {
  all,
  completed,
  active;
}

final todoListFilter = StateProvider((ref) => TodoListFilter.all);

final todoListProvider = StateNotifierProvider<TodoListManager, List<Todo>>((ref) {
  return TodoListManager([
    Todo(id: Uuid().v4(), description: '買い物'),
    Todo(id: Uuid().v4(), description: '学校'),
    Todo(id: Uuid().v4(), description: '宿題'),
  ]);
});

final filteredTodoList = Provider<List<Todo>>(
  (ref) {
    final filter = ref.watch(todoListFilter);
    final filteredList = ref.watch(todoListProvider);

    switch (filter) {
      case TodoListFilter.all:
        return filteredList;
      case TodoListFilter.completed:
        return filteredList.where((todo) => todo.isCompleted).toList();
      case TodoListFilter.active:
        return filteredList.where((todo) => !todo.isCompleted).toList();
    }
  },
);

final unCompletedTodosProvider = Provider<int>((ref) {
  final allTodos = ref.watch(todoListProvider);
  final count = allTodos.where((todo) => !todo.isCompleted).length;
  return count;
});

final currentTodoProvider = Provider<Todo>((ref) => throw UnimplementedError());
