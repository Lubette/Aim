import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/instance_manager.dart';
import 'package:lubette_todo_flutter/controls/main_control.dart';
import 'package:lubette_todo_flutter/controls/use_hooks.dart';
import 'package:lubette_todo_flutter/data/todo_task.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class TodoDetailsPage extends HookWidget {
  const TodoDetailsPage({super.key, required this.todo});
  final TodoTask todo;
  @override
  Widget build(BuildContext context) {
    final media = useMediaQuery(context);
    final theme = useTheme(context);
    final completed = useState(todo.isCompleted);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          todo.title,
          style: ShadTheme.of(
            context,
          ).textTheme.h4,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: useEdgeNoOnly(
            width: media.size.width * 0.04,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: media.size.height * 0.04,
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
                            '${todo.startDate.year}-${todo.startDate.month}-${todo.startDate.day} ${todo.startDate.hour}:${todo.startDate.minute}:${todo.startDate.second}',
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
                        child: MarkdownBlock(
                          data: todo.description,
                          config: MarkdownConfig(
                            configs: [
                              PConfig(
                                textStyle: ShadTheme.of(
                                  context,
                                ).textTheme.p,
                              ),
                              CodeConfig(
                                style: ShadTheme.of(
                                  context,
                                ).textTheme.p,
                              ),
                              LinkConfig(
                                onTap: (value) => launchUrl(
                                  Uri.parse(
                                    value,
                                  ),
                                ).then(
                                  (result) => result
                                      ? EasyLoading.showToast('打开链接成功')
                                      : EasyLoading.showToast('打开链接失败'),
                                ),
                                style: ShadTheme.of(
                                  context,
                                ).textTheme.p.copyWith(
                                      color: ShadTheme.of(
                                        context,
                                      ).colorScheme.primary,
                                      fontStyle: FontStyle.italic,
                                      decoration: TextDecoration.underline,
                                    ),
                              ),
                              PreConfig(
                                theme: atomOneDarkTheme,
                              ),
                              CodeConfig(
                                style: TextStyle(
                                  fontFamily: 'JBMN',
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.colorScheme.onSecondary,
        onPressed: () {
          if (!completed.value) {
            if (Get.find<MainControl>().completed(todo.id)) {
              completed.value = true;
              EasyLoading.showToast(
                '完成任务',
              );
            } else {
              EasyLoading.showToast(
                '不知道什么原因没有完成任务',
              );
            }
          }
        },
        child: Icon(
          Icons.done,
          color: theme.colorScheme.secondary,
        ),
      ),
    );
  }
}
