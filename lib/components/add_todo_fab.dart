import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lubette_todo_flutter/controls/main_control.dart';
import 'package:lubette_todo_flutter/controls/use_hooks.dart';
import 'package:lubette_todo_flutter/data/todo_task.dart';
import 'package:lubette_todo_flutter/pages/add_todo_page.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:uuid/v8.dart';

class AddTodoFab extends StatelessWidget {
  const AddTodoFab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    return FloatingActionButton(
      backgroundColor: ShadTheme.of(context).primaryButtonTheme.backgroundColor,
      onPressed: () => Get.to(
        () {
          final control = Get.find<MainControl>();
          return TodoPage(
            taskType: TodoTaskType.today,
            title: '添加每日任务',
            todo: TodoTask(id: '', title: '', startDate: DateTime.now()),
            firstPressed: (todo) {
              todo.id = control.generateTodoUUID(UuidV8());
              control.addTodayTodo(todo);
              Get.back();
            },
            firstText: '添加',
            secendPressed: (_) {
              Get.back();
            },
            secendText: '退出',
          );
        },
      ),
      child: Icon(
        Icons.add,
        color: ShadTheme.of(context).primaryButtonTheme.foregroundColor,
      ),
    );
  }
}
