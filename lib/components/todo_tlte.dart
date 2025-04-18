import 'package:aim/data/todo_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aim/controls/main_control.dart';
import 'package:aim/components/show_add_todo_sheet.dart';
import 'package:aim/pages/todo_details_page.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TodoCard extends StatelessWidget {
  final TodoEntity todo;

  const TodoCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 250,
      child: ShadContextMenuRegion(
        constraints: const BoxConstraints(minWidth: 200),
        items: [
          ShadContextMenuItem.inset(
            child: Text('开始计时'),
            // onPressed: () => Get.to(
            //   () => CountTimePage(
            //     todo,
            //   ),
            // ),
            onPressed: () {},
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
              control.removeTodoTask(todo.key);
            },
          ),
        ],
        child: ShadCard(
          child: Padding(
            padding: const EdgeInsets.all(10),
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
                        text: todo.compeled ? '已完成' : '未完成',
                        style: ShadTheme.of(context).textTheme.p,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: LayoutBuilder(builder: (context, box) {
                    final lines = (box.maxHeight / (17 * 1.5)).toInt();
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
                  }),
                ),
                Row(
                  children: [
                    ...buildButton(
                      context,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildButton(BuildContext context) {
    return [
      Visibility(
        visible: !todo.compeled,
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ShadButton.outline(
              // onPressed: () => Get.to(
              //   () => CountTimePage(
              //     todo,
              //   ),
              // ),
              onPressed: () {},
              child: Text(
                '开始计时',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding:
              todo.compeled ? EdgeInsets.zero : const EdgeInsets.only(left: 10),
          child: ShadButton.outline(
            onPressed: () => Get.to(
              () => TodoDetailsPage(
                todo: todo,
              ),
            ),
            child: Text(
              '查看详情',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ];
  }

  String markdownToPlainText(String markdown) {
    List<String> lines = markdown.split('\n');
    List<String> plainTextLines = [];

    for (var line in lines) {
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
    }

    // Join lines and remove multiple spaces
    return plainTextLines
        .map((line) => line.replaceAll(RegExp(r'\s+'), ''))
        .join(' ')
        .replaceAll(RegExp(r'\s{2,}'), '')
        .trim();
  }
}
