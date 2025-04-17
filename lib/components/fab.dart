import 'package:aim/components/show_add_todo_group_name_sheet.dart';
import 'package:aim/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../controls/main_control.dart';
import '../data/group_entity.dart';
import '../data/todo_entity.dart';
import 'add_todo_page.dart';

class Fab extends StatelessWidget {
  const Fab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context).textTheme;
    return ExpandableFab(
      type: ExpandableFabType.fan,
      childrenAnimation: ExpandableFabAnimation.none,
      children: [
        Row(
          children: [
            Text('任务',style: theme.p,),
            SizedBox(width: 20),
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                final control = Get.find<MainControl>();
                return showAddTodoSheet(
                  selectEnable: false,
                  todosId: 'Today',
                  title: '任务',
                  todo: TodoEntity(),
                  firstPressed: (id, todo) {
                    control.addTodoTask(id, todo);
                  },
                  firstText: '添加',
                  secendPressed: (_, __) {},
                  secendText: '',
                  context: context,
                );
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
        Row(
          children: [
            Text('任务组',style: theme.p,),
            SizedBox(width: 20),
            GetBuilder<MainControl>(builder: (logic) {
              return FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  showAddTodoGroupNameSheet(
                    context: context,
                    onGroupNameSubmitted: (String name) {
                      // 在这里处理用户输入的组名
                      debugPrint('用户输入的组名: $name');
                      logic.addGroup(GroupEntity.fromName(name));
                      // 你可以在这里执行保存操作等
                    },
                  );
                },
                child: Icon(Icons.add_card),
              );
            }),
          ],
        ),
        Row(
          children: [
            Text('设置',style: theme.p,),
            SizedBox(width: 20),
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Get.to(() => SettingsPage());
              },
              child: Icon(Icons.settings),
            ),
          ],
        ),
      ],
    );
  }
}
