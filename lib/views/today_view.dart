import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aim/components/add_todo_fab.dart';
import 'package:aim/controls/main_control.dart';
import 'package:aim/controls/use_hooks.dart';
import 'package:aim/data/todo_task.dart';
import 'package:aim/views/todo_view.dart';

class TodosView extends StatelessWidget {
  final String title;
  final List<TodoTask> todos;
  const TodosView({
    super.key,
    required this.title,
    required this.todos,
  });

  @override
  Widget build(BuildContext context) {
    final media = useMediaQuery(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(
          media.size.height * 0.025,
        ),
        child: TodoView(
          todos: todos,
        ),
      ),
      floatingActionButton: AddTodoFab(),
    );
  }
}
