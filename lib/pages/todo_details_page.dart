import 'package:aim/data/todo_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/instance_manager.dart';
import 'package:aim/controls/main_control.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class TodoDetailsPage extends HookWidget {
  final TodoEntity todo;

  const TodoDetailsPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    final completed = useState(todo.compeled);
    final tdate = DateTime.parse(todo.createdDate);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          todo.title,
          style: ShadTheme.of(
            context,
          ).textTheme.h4,
        ),
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: media.width * 0.04,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: media.height * 0.04,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 10,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '任务状态：',
                        style: ShadTheme.of(
                          context,
                        ).textTheme.h4.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      TextSpan(
                        text: completed.value ? '已完成' : '未完成',
                        style: ShadTheme.of(
                          context,
                        ).textTheme.h4,
                      )
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '创建时间：',
                        style: ShadTheme.of(
                          context,
                        ).textTheme.h4.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      TextSpan(
                        text:
                            '${tdate.year}-${tdate.month}-${tdate.day} ${tdate.hour}:${tdate.minute}:${tdate.second}',
                        style: ShadTheme.of(
                          context,
                        ).textTheme.h4,
                      )
                    ],
                  ),
                ),
                // Row(
                //   children: [
                //     Text(
                //       '任务详情：',
                //       style: ShadTheme.of(
                //         context,
                //       ).textTheme.h4.copyWith(
                //             fontWeight: FontWeight.bold,
                //           ),
                //     ),
                //     todo.description.isNotEmpty
                //         ? Container()
                //         : Text(
                //             '无',
                //             style: ShadTheme.of(
                //               context,
                //             ).textTheme.h4,
                //           ),
                //   ],
                // ),
                todo.description.isEmpty
                    ? Container()
                    : ShadCard(
                        child: MarkdownBody(
                          data: todo.description,
                          selectable: true,
                          styleSheet: MarkdownStyleSheet(
                            p: ShadTheme.of(context).textTheme.p,
                            code: ShadTheme.of(context).textTheme.p,
                            h1: ShadTheme.of(context).textTheme.h1,
                            h2: ShadTheme.of(context).textTheme.h2,
                            h3: ShadTheme.of(context).textTheme.h3,
                            h4: ShadTheme.of(context).textTheme.h4,
                          ),
                          onTapLink: (url, source, referer) {
                            debugPrint('打开链接：$url');
                            debugPrint('$source');
                            debugPrint(referer);
                            if (source != null) {
                              launchUrl(
                                Uri.parse(
                                  source,
                                ),
                              ).then(
                                (result) => result
                                    ? EasyLoading.showToast('打开链接成功')
                                    : EasyLoading.showToast('打开链接失败'),
                              );
                            }
                          },
                        ),
                        // child: MarkdownBlock(
                        //   data: todo.description,
                        //   config: MarkdownConfig(
                        //     configs: [
                        //       PConfig(
                        //         textStyle: ShadTheme.of(
                        //           context,
                        //         ).textTheme.p,
                        //       ),
                        //       CodeConfig(
                        //         style: ShadTheme.of(
                        //           context,
                        //         ).textTheme.p,
                        //       ),
                        //       LinkConfig(
                        //         onTap: (value) => launchUrl(
                        //           Uri.parse(
                        //             value,
                        //           ),
                        //         ).then(
                        //           (result) => result
                        //               ? EasyLoading.showToast('打开链接成功')
                        //               : EasyLoading.showToast('打开链接失败'),
                        //         ),
                        //         style: ShadTheme.of(
                        //           context,
                        //         ).textTheme.p.copyWith(
                        //               color: ShadTheme.of(
                        //                 context,
                        //               ).colorScheme.primary,
                        //               fontStyle: FontStyle.italic,
                        //               decoration: TextDecoration.underline,
                        //             ),
                        //       ),
                        //       PreConfig(
                        //         theme: atomOneDarkTheme,
                        //         textStyle: TextStyle(
                        //           fontFamily: 'JBMN',
                        //         ),
                        //       ),
                        //       CodeConfig(
                        //         style: ShadTheme.of(
                        //           context,
                        //         ).textTheme.p.copyWith(
                        //               fontFamily: 'JBMN',
                        //             ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            ShadTheme.of(context).primaryButtonTheme.backgroundColor,
        onPressed: () {
          if (!completed.value) {
            (Get.find<MainControl>().completedTodo(todo.key));
            completed.value = true;
            EasyLoading.showToast(
              '完成任务',
            );
          }
        },
        child: Icon(
          Icons.done,
          color: ShadTheme.of(context).primaryButtonTheme.foregroundColor,
        ),
      ),
    );
  }
}
