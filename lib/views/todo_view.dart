import 'package:flutter/material.dart';
import 'package:lubette_todo_flutter/components/todo_card.dart';
import 'package:lubette_todo_flutter/controls/use_hooks.dart';
import 'package:lubette_todo_flutter/data/todo_task.dart';

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
    return LayoutBuilder(
      builder: (context, box) {
        final count = () {
          return (box.maxWidth / 350).toInt() != 0
              ? (box.maxWidth / 350).toInt()
              : 1;
        }();
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            childAspectRatio: 5 / 3,
            crossAxisSpacing: media.size.width * media.size.height * 0.000025,
            mainAxisSpacing: media.size.width * media.size.height * 0.000025,
          ),
          itemBuilder: (context, index) {
            return TodoCard(todo: todos[index]);
          },
          itemCount: todos.length,
        );
      },
    );
  }
}
