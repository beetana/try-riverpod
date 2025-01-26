import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_tutorial/provider/all_providers.dart';

class ToolbarWidget extends ConsumerWidget {
  const ToolbarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unCompletedTodoCount = ref.watch(unCompletedTodosProvider);
    // final filterdList = ref.watch(todoListFilter);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text('$unCompletedTodoCount ToDo'),
        ),
        Tooltip(
          message: 'すべてのToDo',
          child: TextButton(
            onPressed: () {
              ref.read(todoListFilter.notifier).state = TodoListFilter.all;
            },
            child: Text('すべて'),
          ),
        ),
        Tooltip(
          message: '未完了のToDo',
          child: TextButton(
            onPressed: () {
              ref.read(todoListFilter.notifier).state = TodoListFilter.active;
            },
            child: Text('未完了'),
          ),
        ),
        Tooltip(
          message: '完了したToDo',
          child: TextButton(
            onPressed: () {
              ref.read(todoListFilter.notifier).state = TodoListFilter.completed;
            },
            child: Text('完了'),
          ),
        ),
      ],
    );
  }
}
