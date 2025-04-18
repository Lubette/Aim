import 'package:aim/data/todo_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aim/controls/main_control.dart';
import 'package:aim/components/show_add_todo_sheet.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AddTodoFab extends StatelessWidget {
  const AddTodoFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: ShadTheme.of(context).primaryButtonTheme.backgroundColor,
      onPressed: () {
        final control = Get.find<MainControl>();
        return showAddTodoSheet(
          selectEnable: true,
          title: '添加任务',
          todo: TodoEntity(),
          firstPressed: (id, todo) {
            control.addTodoTask(id, todo);
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
