import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lubette_todo_flutter/controls/main_control.dart';
import 'package:lubette_todo_flutter/controls/use_hooks.dart';
import 'package:lubette_todo_flutter/data/todo_task.dart';
import 'package:lubette_todo_flutter/pages/add_todo_page.dart';
import 'package:lubette_todo_flutter/pages/count_time_page.dart';
import 'package:lubette_todo_flutter/components/text_button.dart' as lubette;
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:lubette_todo_flutter/pages/todo_details_page.dart';

class TodoCard extends StatelessWidget {
  TodoCard({super.key, required this.todo}) {
    menu = ContextMenu(
      borderRadius: BorderRadius.circular(0),
      boxDecoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1.5,
        ),
      ),
      entries: <ContextMenuEntry>[
        MenuItem(
          label: '修改',
          icon: Icons.create,
          onSelected: () {
            Get.to(
              TodoPage(
                taskType: TodoTaskType.normal,
                title: '修改Todo',
                todo: todo,
                firstPressed: (todo) {
                  final controller = Get.find<MainControl>();
                  controller.setTodo(todo);
                  Get.back();
                },
                secendPressed: (_) => Get.back(),
                firstText: '修改',
                secendText: '退出',
              ),
            );
          },
        ),
        MenuItem(
          label: '删除',
          icon: Icons.delete,
          onSelected: () {
            final control = Get.find<MainControl>();
            control.removeTodo(todo.id);
          },
        ),
      ],
      padding: const EdgeInsets.all(8.0),
    );
  }
  final TodoTask todo;

  late ContextMenu menu;
  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    return Listener(
      onPointerDown: (event) {
        printInfo(info: '${event.buttons}');
        if (event.kind == PointerDeviceKind.mouse) {
          // 判断是否是右键
          if (event.buttons == 2) {
            menu.position = event.position;
            showContextMenu(context, contextMenu: menu);
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          border: Border.all(
            width: 1.5,
          ),
        ),
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
                    style: TextStyle(
                      color: theme.colorScheme.onPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '任务状态：',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onPrimary,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: todo.isCompleted ? '已完成' : '未完成',
                          style: TextStyle(
                            color: theme.colorScheme.onPrimary,
                            fontSize: 16,
                          ),
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
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onPrimary,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: markdownToPlainText(
                                todo.description.isNotEmpty
                                    ? todo.description
                                    : '无',
                              ),
                              style: TextStyle(
                                color: theme.colorScheme.onPrimary,
                                fontFamily: 'JBMN',
                                fontSize: 16,
                              ),
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
            control.completed(todo.id);
          };
    return [
      Visibility(
        visible: !todo.isCompleted,
        child: Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: size.$1 * 0.01),
            child: lubette.TextButton(
              onPress: () => Get.to(
                () => CountTimePage(
                  todo,
                ),
              ),
              text: Padding(
                padding: useEdgeNoOnly(height: size.$2 * 0.04),
                child: Text('开始计时'),
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(left: size.$1 * 0.01),
          child: lubette.TextButton(
            onPress: () => Get.to(
              () => TodoDetailsPage(
                todo: todo,
              ),
            ),
            text: Padding(
              padding: useEdgeNoOnly(height: size.$2 * 0.04),
              child: Text(
                '查看详情',
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
