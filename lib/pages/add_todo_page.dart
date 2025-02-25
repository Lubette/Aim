import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lubette_todo_flutter/controls/main_control.dart';
import 'package:lubette_todo_flutter/controls/use_hooks.dart';
import 'package:lubette_todo_flutter/data/todo_task.dart';
import 'package:lubette_todo_flutter/components/text_box.dart';
import 'package:lubette_todo_flutter/components/text_button.dart' as lubette;
import 'package:shadcn_ui/shadcn_ui.dart';

class TodoPage extends StatelessWidget {
  TodoPage({
    super.key,
    required this.taskType,
    required this.title,
    required this.todo,
    required this.firstPressed,
    required this.secendPressed,
    required this.firstText,
    required this.secendText,
  }) {
    _titleControl.text = todo.title;
    _docControl.text = todo.description;
  }
  final TodoTaskType taskType;

  final String title;

  final _titleControl = TextEditingController();
  final _docControl = TextEditingController();
  final _dueDateControl = TextEditingController();
  final TodoTask todo;
  final void Function(TodoTask) firstPressed;
  final void Function(TodoTask) secendPressed;
  final String firstText;
  final String secendText;
  @override
  Widget build(BuildContext context) {
    final media = useMediaQuery(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: ShadTheme.of(
            context,
          ).textTheme.h4,
        ),
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: useEdgeNoOnly(
            width: media.size.width * 0.04,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: media.size.height * 0.02,
            children: [
              ShadInputFormField(
                placeholder: Text(
                  '输入标题',
                  style: ShadTheme.of(
                    context,
                  ).textTheme.p,
                ),
                label: Text(
                  '任务标题',
                  style: ShadTheme.of(
                    context,
                  ).textTheme.h4.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                maxLines: null,
                minLines: 1,
                controller: _titleControl,
                style: ShadTheme.of(
                  context,
                ).textTheme.p,
              ),
              ShadInputFormField(
                placeholder: Text(
                  '输入内容',
                  style: ShadTheme.of(
                    context,
                  ).textTheme.p,
                ),
                label: Text(
                  '任务内容',
                  style: ShadTheme.of(
                    context,
                  ).textTheme.h4.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                maxLines: null,
                minLines: 2,
                controller: _docControl,
                style: ShadTheme.of(
                  context,
                ).textTheme.p,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShadDatePickerFormField(
                    label: Text(
                      '截至日期',
                      style: ShadTheme.of(
                        context,
                      ).textTheme.h4.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    placeholder: Text(
                      '选择截至日期',
                      style: ShadTheme.of(
                        context,
                      ).textTheme.p,
                    ),
                    onSaved: (date) {
                      _dueDateControl.text = date.toString();
                    },
                  ),
                  Spacer(),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: media.size.width * 0.02,
                      ),
                      child: SizedBox(
                        height: media.size.height * 0.08,
                        child: GetBuilder<MainControl>(
                          builder: (control) {
                            return ShadButton(
                              onPressed: () {
                                todo.title = _titleControl.text;
                                todo.description = _docControl.text;
                                firstPressed(
                                  todo,
                                );
                              },
                              child: Text(
                                firstText,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: media.size.width * 0.02,
                      ),
                      child: SizedBox(
                        height: media.size.height * 0.08,
                        child: ShadButton.outline(
                          onPressed: () => secendPressed(todo),
                          child: Text(
                            secendText,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
