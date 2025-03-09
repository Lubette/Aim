import 'package:flutter/material.dart';
import 'package:aim/components/todo_card.dart';
import 'package:aim/controls/use_hooks.dart';
import 'package:aim/data/todo_task.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key, required this.todos});
  final List<TodoTask> todos;
  @override
  Widget build(BuildContext context) {
    final media = useMediaQuery(context);
    if (todos.isEmpty) {
      return Center(
        child: Text('没有任务哟~'),
      );
    }
    return Wrap(
      children: todos
          .map(
            (ele) => TodoCard(
              todo: ele,
            ),
          )
          .toList(),
    );
  }
}
