import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_tutorial/provider/all_providers.dart';
import 'package:riverpod_todo_tutorial/using_future_provider.dart';
import 'package:riverpod_todo_tutorial/widgets/title_widget.dart';
import 'package:riverpod_todo_tutorial/widgets/todo_listitem_widget.dart';
import 'package:riverpod_todo_tutorial/widgets/toolbar_widget.dart';

class TodoApp extends ConsumerWidget {
  TodoApp({super.key});

  final newTodoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allTodos = ref.watch(filteredTodoList);

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        children: [
          TitleWidget(),
          TextField(
            controller: newTodoController,
            decoration: InputDecoration(
              labelText: 'ToDoを追加',
              labelStyle: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w300,
              ),
            ),
            onSubmitted: (value) {
              ref.read(todoListProvider.notifier).add(value);
            },
          ),
          ToolbarWidget(),
          for (int i = 0; i < allTodos.length; i++)
            Dismissible(
              key: ValueKey(allTodos[i].id),
              onDismissed: (_) {
                ref.read(todoListProvider.notifier).delete(allTodos[i]);
              },
              child: ProviderScope(
                overrides: [
                  currentTodoProvider.overrideWithValue(allTodos[i]),
                ],
                child: TodoListItemWidget(),
              ),
            ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => UsingFutureProvider()),
                ),
              );
            },
            child: Text(
              'Future Providerを使う',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
