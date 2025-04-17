import 'package:aim/data/todo_entity.dart';
import 'package:flutter/material.dart';
import 'package:aim/components/add_todo_fab.dart';
import 'package:aim/views/todo_view.dart';

class TodosView extends StatelessWidget {
  final String title;
  final List<TodoEntity> todos;
  const TodosView({
    super.key,
    required this.title,
    required this.todos,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(
          media.height * 0.025,
        ),
        child: TodoView(
          todos: todos,
        ),
      ),
      floatingActionButton: AddTodoFab(),
    );
  }
}
