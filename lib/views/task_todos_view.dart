import 'package:aim/data/todo_entity.dart';
import 'package:flutter/material.dart';
import 'package:aim/views/todo_view.dart';

class TaskTodosView extends StatelessWidget {
  const TaskTodosView({
    super.key,
    required this.tasksName,
    required this.tasks,
  });
  final String tasksName;
  final List<TodoEntity> tasks;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 1,
              bottom: 10,
            ),
            child: Text(
              tasksName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: TodoView(
              todos: tasks,
            ),
          ),
        ],
      ),
    );
  }
}
