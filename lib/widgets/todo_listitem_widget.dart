import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_tutorial/model/todo.dart';
import 'package:riverpod_todo_tutorial/provider/all_providers.dart';

class TodoListItemWidget extends ConsumerStatefulWidget {
  // final Todo todo;

  const TodoListItemWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoListItemWidgetState();
}

class _TodoListItemWidgetState extends ConsumerState<TodoListItemWidget> {
  late FocusNode textFocusNode;
  late TextEditingController textEditingController;
  bool hasFocus = false;

  @override
  void initState() {
    super.initState();
    textFocusNode = FocusNode();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textFocusNode.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTodo = ref.watch(currentTodoProvider);

    return Focus(
      onFocusChange: (value) {
        if (!value) {
          setState(() {
            hasFocus = false;
          });
        }
        ref.read(todoListProvider.notifier).edit(
              id: currentTodo.id,
              newDescription: textEditingController.text,
            );
      },
      child: ListTile(
        title: hasFocus
            ? TextField(
                controller: textEditingController,
                focusNode: textFocusNode,
              )
            : Text(currentTodo.description),
        leading: Checkbox(
          value: currentTodo.isCompleted,
          onChanged: (value) {
            ref.read(todoListProvider.notifier).toggle(currentTodo.id);
          },
        ),
        onTap: () {
          setState(() {
            hasFocus = true;
          });
          textFocusNode.requestFocus();
          textEditingController.text = currentTodo.description;
        },
      ),
    );
  }
}
