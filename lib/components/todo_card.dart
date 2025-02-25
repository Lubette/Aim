import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lubette_todo_flutter/controls/main_control.dart';
import 'package:lubette_todo_flutter/controls/use_hooks.dart';
import 'package:lubette_todo_flutter/data/todo_task.dart';
import 'package:lubette_todo_flutter/components/add_todo_page.dart';
import 'package:lubette_todo_flutter/pages/count_time_page.dart';
import 'package:lubette_todo_flutter/pages/todo_details_page.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TodoCard extends StatelessWidget {
  final TodoTask todo;
  const TodoCard({super.key, required this.todo});
  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    return ShadContextMenuRegion(
      constraints: const BoxConstraints(minWidth: 200),
      items: [
        ShadContextMenuItem.inset(
          child: Text('开始计时'),
          onPressed: () => Get.to(
            () => CountTimePage(
              todo,
            ),
          ),
        ),
        ShadContextMenuItem.inset(
          child: Text('查看详情'),
          onPressed: () => Get.to(
            () => TodoDetailsPage(
              todo: todo,
            ),
          ),
        ),
        ShadContextMenuItem.inset(
          child: Text('修改内容'),
          onPressed: () => showAddTodoSheet(
            taskType: TodoTaskType.normal,
            title: '修改Todo',
            selectEnable: false,
            todo: todo,
            firstPressed: (_, todo) {
              final controller = Get.find<MainControl>();
              controller.updateTodoTask(todo);
              Get.back();
            },
            secendPressed: (_, __) => Get.back(),
            firstText: '修改',
            secendText: '退出',
            context: context,
          ),
        ),
        ShadContextMenuItem.inset(
          child: Text('删除Todo'),
          onPressed: () {
            final control = Get.find<MainControl>();
            control.removeTodoTask(todo.id);
          },
        ),
      ],
      child: ShadCard(
        child: LayoutBuilder(
          builder: (context, box) {
            return Padding(
              // padding: EdgeInsets.only(
              //   left: media.size.width * 0.02,
              //   right: media.size.width * 0.02,
              //   top: media.size.height * 0.02,
              //   bottom: media.size.height * 0.02,
              // ),
              padding: useEdgeNoOnly(
                width: box.minWidth * 0.06,
                height: box.minHeight * 0.06,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    maxLines: 1,
                    style: ShadTheme.of(
                      context,
                    ).textTheme.h4.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '任务状态：',
                          style: ShadTheme.of(context).textTheme.p,
                        ),
                        TextSpan(
                          text: todo.isCompleted ? '已完成' : '未完成',
                          style: ShadTheme.of(context).textTheme.p,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: LayoutBuilder(builder: (context, box) {
                      final lines = (box.maxHeight / (17 * 1.5)).toInt();
                      printInfo(
                          info: '!!!!${(box.maxHeight / (16 * 1.5)).toInt()}');
                      return RichText(
                        maxLines: lines,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '任务内容：',
                              style: ShadTheme.of(context).textTheme.p,
                            ),
                            TextSpan(
                              text: markdownToPlainText(
                                todo.description.isNotEmpty
                                    ? todo.description
                                    : '无',
                              ),
                              style: ShadTheme.of(context).textTheme.p,
                            )
                          ],
                        ),
                      );
                      // return Text(
                      //   '任务内容：${todo.description}',
                      //   maxLines: lines,
                      //   overflow: TextOverflow.ellipsis,
                      //   style: TextStyle(
                      //     color: theme.colorScheme.onPrimary,
                      //     fontSize: 17,
                      //   ),
                      // );
                    }),
                  ),
                  Row(
                    children: [
                      ...buildButton(
                        context,
                        (
                          box.maxWidth,
                          box.maxHeight,
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> buildButton(BuildContext context, (double, double) size) {
    final title = todo.isCompleted ? '查看详情' : '结束任务';
    final func = todo.isCompleted
        ? () {}
        : () {
            final control = Get.find<MainControl>();
            control.completedTodo(todo.id);
          };
    return [
      Visibility(
        visible: !todo.isCompleted,
        child: Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: size.$1 * 0.01),
            child: ShadButton.outline(
              onPressed: () => Get.to(
                () => CountTimePage(
                  todo,
                ),
              ),
              child: Text('开始计时'),
            ),
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(left: size.$1 * 0.01),
          child: ShadButton.outline(
            onPressed: () => Get.to(
              () => TodoDetailsPage(
                todo: todo,
              ),
            ),
            child: Text(
              '查看详情',
            ),
          ),
        ),
      ),
    ];
  }

  String markdownToPlainText(String markdown) {
    List<String> lines = markdown.split('\n');
    List<String> plainTextLines = [];

    lines.forEach((line) {
      // Remove Markdown headers (e.g., # Header)
      line = line.replaceAll(RegExp(r'^#{1,6} '), '');

      // Remove bold and italic markers (e.g., **bold** or *italic*)
      line = line.replaceAll(RegExp(r'\*{1,2}(.*?)\*{1,2}'), r'');
      line = line.replaceAll(RegExp(r'_{1,2}(.*?)_{1,2}'), r'');

      // Remove code blocks (e.g., `code` or ```code```)
      line = line.replaceAll(RegExp(r'`{1,3}(.*?)`{1,3}'), r'');

      // Remove links (e.g., [description](url))
      line = line.replaceAll(RegExp(r'\[(.*?)\]\(.*?\)'), r'');

      // Remove unordered list markers (e.g., * item, - item)
      line = line.replaceAll(RegExp(r'^[\*+-] '), '');

      // Remove ordered list markers (e.g., 1. item)
      line = line.replaceAll(RegExp(r'^\d+\. '), '');

      // Remove block quotes (e.g., > quote)
      line = line.replaceAll(RegExp(r'^> '), '');

      // Handle empty lines
      plainTextLines.add(line.trim());
    });

    // Join lines and remove multiple spaces
    return plainTextLines
        .map((line) => line.replaceAll(RegExp(r'\s+'), ''))
        .join(' ')
        .replaceAll(RegExp(r'\s{2,}'), '')
        .trim();
  }
}
