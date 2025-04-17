import 'package:aim/data/todo_entity.dart';
import 'package:flutter/material.dart';
import 'package:aim/components/todo_tlte.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key, required this.todos});
  final List<TodoEntity> todos;
  @override
  Widget build(BuildContext context) {
    // final media = MediaQuery.sizeOf(context);
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
