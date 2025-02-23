import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lubette_todo_flutter/controls/main_control.dart';
import 'package:lubette_todo_flutter/controls/use_hooks.dart';
import 'package:lubette_todo_flutter/data/todo_task.dart';
import 'package:lubette_todo_flutter/components/text_box.dart';
import 'package:lubette_todo_flutter/components/text_button.dart' as lubette;

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
        toolbarHeight: media.size.height * 0.09,
        title: Text(
          title,
        ),
      ),
      body: Padding(
        padding: useEdgeNoOnly(
          width: media.size.width * 0.04,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: media.size.height * 0.02,
          children: [
            TextBox(
              '任务标题',
              maxLines: 1,
              controller: _titleControl,
            ),
            TextBox(
              '具体内容',
              maxLines: null,
              minLines: 2,
              controller: _docControl,
            ),
            buildDatePick(context),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          return lubette.TextButton(
                            onPress: () {
                              todo.title = _titleControl.text;
                              todo.description = _docControl.text;
                              firstPressed(
                                todo,
                              );
                            },
                            text: Text(
                              firstText,
                              style: TextStyle(
                                fontSize: 17,
                              ),
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
                      child: lubette.TextButton(
                        onPress: () => secendPressed(todo),
                        text: Text(
                          secendText,
                          style: TextStyle(
                            fontSize: 17,
                          ),
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
    );
  }

  Widget buildDatePick(BuildContext context) {
    if (taskType == TodoTaskType.today) {
      return Container();
    }
    final theme = useTheme(context);
    return TextBox(
      '截至日期',
      controller: _dueDateControl,
      readOnly: true,
      onTap: () => showDatePicker(
          context: context,
          helpText: '选择截至日期',
          initialDate: DateTime.now(),
          initialDatePickerMode: DatePickerMode.day,
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(
            Duration(
              days: 365 * 10,
            ),
          ),
          builder: (context, Widget? child) {
            return Theme(
              data: ThemeData(
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                        foregroundColor: theme.colorScheme.onPrimary)),
                colorScheme: ColorScheme.light(
                    primary: theme.colorScheme.onPrimary,
                    onPrimary: Colors.white),
              ),
              child: child!,
            );
          }).then((time) {
        todo.dueDate = time ?? DateTime.now();
        _dueDateControl.text = '${todo.dueDate}';
      }),
    );
  }
}
