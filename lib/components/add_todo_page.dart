
import 'package:aim/data/todo_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aim/controls/main_control.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void showAddTodoSheet({
  required BuildContext context,
  required String title,
  required TodoEntity todo,
  required void Function(String, TodoEntity) firstPressed,
  required void Function(String, TodoEntity) secendPressed,
  required String firstText,
  required String secendText,
  String? todosId,
  required bool selectEnable,
}) {
  final titleControl = TextEditingController(text: todo.title);
  final docControl = TextEditingController(text: todo.description);
  final dueDateControl = TextEditingController();

  showShadSheet(
    context: context,
    side: ShadSheetSide.right,
    builder: (context) => ShadSheet(
      title: Text(title),
      constraints: BoxConstraints(maxWidth: 512),
      description: const Text('添加新的待办事项'),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              if (selectEnable)
                GetBuilder<MainControl>(builder: (logic) {
                  return ShadSelectFormField<String>(
                    placeholder: const Text('选择要添加的任务组'),
                    label: const Text('任务组'),
                    options: logic.groups
                        .map((group) => (group.key, group.name))
                        .toList()
                        .cast<(String, String)>()
                        .map((e) => ShadOption<String>(
                              value: e.$1,
                              child: Text(e.$2),
                            ))
                        .toList(),
                    selectedOptionBuilder: (context, value) => value == 'none'
                        ? const Text('Select a verified email to display')
                        : Text(
                            logic.groups
                                .firstWhere(
                                  (element) => element.key == value,
                                )
                                .name,
                          ),
                    onChanged: (String? id) => todosId = id ?? '',
                  );
                }),
              const SizedBox(height: 16),
              ShadInputFormField(
                controller: titleControl,
                placeholder: const Text('输入标题'),
                label: const Text('任务标题'),
              ),
              const SizedBox(height: 16),
              ShadInputFormField(
                controller: docControl,
                placeholder: const Text('输入内容'),
                label: const Text('任务内容'),
                minLines: 3,
                maxLines: 5,
              ),
              const SizedBox(height: 16),
              ShadDatePickerFormField(
                onChanged: (DateTime? time) {
                  if (time != null) {
                    dueDateControl.text = time.toIso8601String();
                  }
                },
                label: const Text('截止日期'),
                placeholder: const Text('选择日期'),
                weekStartsOn: 1,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Visibility(
                    visible: firstText != '',
                    child: ShadButton(
                      child: Text(firstText),
                      onPressed: () {
                        todo.title = titleControl.text;
                        todo.description = docControl.text;
                        todo.dueDate = dueDateControl.text;
                        firstPressed(todosId ?? '', todo);
                        Get.back();
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Visibility(
                    visible: secendText != '',
                    child: ShadButton.outline(
                      child: Text(secendText),
                      onPressed: () {
                        secendPressed(todosId ?? '', todo);
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
