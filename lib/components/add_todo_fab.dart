import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lubette_todo_flutter/controls/main_control.dart';
import 'package:lubette_todo_flutter/controls/use_hooks.dart';
import 'package:lubette_todo_flutter/data/todo_task.dart';
import 'package:lubette_todo_flutter/components/add_todo_page.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:uuid/v8.dart';

class AddTodoFab extends StatelessWidget {
  const AddTodoFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: ShadTheme.of(context).primaryButtonTheme.backgroundColor,
      onPressed: () {
        final control = Get.find<MainControl>();
        return showAddTodoSheet(
          taskType: TodoTaskType.today,
          selectEnable: true,
          title: '添加任务',
          todo: TodoTask(
            id: '',
            title: '',
            startDate: DateTime.now().toString(),
            description: '',
          ),
          firstPressed: (id, todo) {
            control.addTodoTask(id, todo);
            Get.back();
          },
          firstText: '添加',
          secendPressed: (_, __) {
            Get.back();
          },
          secendText: '退出',
          context: context,
        );
      },
      child: Icon(
        Icons.add,
        color: ShadTheme.of(context).primaryButtonTheme.foregroundColor,
      ),
    );
  }
}
