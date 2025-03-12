import 'package:aim/components/task.dart';
import 'package:aim/controls/main_control.dart';
import 'package:aim/data/todo_tasks.dart';
import 'package:flutter/material.dart';
import 'package:aim/components/navigation_item.dart';
import 'package:aim/controls/use_hooks.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Navigation extends StatelessWidget {
  const Navigation({
    super.key,
    required this.items,
    required this.onItemTap,
    required this.selected,
  });
  final List<NavigationItem> items;
  final void Function(int) onItemTap;
  final int selected;

  @override
  Widget build(BuildContext context) {
    var count = 0;
    final media = useMediaQuery(context);
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 70,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ...items.map(
              (element) {
                final value = count++;
                return InkWell(
                  onTap: () => onItemTap(value),
                  child: element,
                );
              },
            ),
            GetBuilder<MainControl>(
              builder: (logic) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ShadIconButton.ghost(
                    icon: Icon(
                      Icons.add_chart,
                    ),
                    iconSize: 25,
                    onPressed: () {
                      showAddTodoGroupNameSheet(
                        context: context,
                        onGroupNameSubmitted: (String name) {
                          // 在这里处理用户输入的组名
                          print('用户输入的组名: $name');
                          logic.addTodoTasks(
                            TodoTasks(
                              todos: [],
                              uuid: logic.generateUniqueUUID(),
                              name: name,
                            ),
                          );
                          // 你可以在这里执行保存操作等
                        },
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
      body: items[selected].content,
    );
    // return Padding(
    //   padding: EdgeInsets.only(
    //     left: media.size.width * 0.01,
    //     right: media.size.width * 0.01,
    //     top: media.size.height * 0.015,
    //   ),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: [
    //       Row(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           ...items.map(
    //             (element) {
    //               final value = count++;
    //               return InkWell(
    //                 onTap: () => onItemTap(value),
    //                 hoverColor: Theme.of(context).primaryColor,
    //                 child: element,
    //               );
    //             },
    //           ),
    //         ],
    //       ),
    //       Expanded(
    //         child: items[selected].content,
    //       )
    //     ],
    //   ),
    // );
  }
}
