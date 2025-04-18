import 'package:aim/components/show_add_todo_sheet.dart';
import 'package:aim/components/fab.dart';
import 'package:aim/components/show_add_todo_group_name_sheet.dart';
import 'package:aim/controls/main_control.dart';
import 'package:aim/data/group_entity.dart';
import 'package:aim/data/todo_entity.dart';
import 'package:aim/views/todo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MainPage extends StatelessWidget {
  final selected = 0.obs;

  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (Get.find<MainControl>().groups.isEmpty) {
      return Center(
        child: Column(
          spacing: 20,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GetBuilder<MainControl>(builder: (logic) {
              return ShadButton(
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
            Text(
              '点击按钮创建第一个组吧',
            )
          ],
        ),
      );
    }
    return Scaffold(
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: Fab(),
      body: Row(
        children: [
          Expanded(child: GetBuilder<MainControl>(builder: (logic) {
            Map<String, List<TodoEntity>> map = {};
            for (var group in logic.groups) {
              for (var todo in logic.todos.values) {
                debugPrint('Todo ${group.key} ${todo.todosKey}');
                if (todo.todosKey == group.key) {
                  map[group.key] = [...?map[group.key], todo];
                }
              }
            }
            final children = [];
            for (var element in map.values) {
              children.add(Padding(
                padding: EdgeInsets.all(50),
                child: TodoView(todos: element),
              ));
            }
            debugPrint('Map:$map');
            return PageView(
              children: [...children],
            );
          }))
        ],
      ),
    );
  }
}
