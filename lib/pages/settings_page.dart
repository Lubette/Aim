import 'package:aim/data/group_entity.dart';
import 'package:aim/data/todo_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:aim/components/show_add_todo_group_name_sheet.dart';
import 'package:aim/controls/main_control.dart';
import 'package:aim/components/show_add_todo_sheet.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const themes = [
    'blue',
    'gray',
    'green',
    'neutral',
    'orange',
    'red',
    'rose',
    'slate',
    'stone',
    'violet',
    'yellow',
    'zinc',
  ];
  static const themeModes = ['dark', 'light', 'system'];

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        type: ExpandableFabType.fan,
        childrenAnimation: ExpandableFabAnimation.none,
        children: [
          Row(
            children: [
              Text('添加任务'),
              SizedBox(width: 20),
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  final control = Get.find<MainControl>();
                  return showAddTodoSheet(
                    selectEnable: true,
                    title: '添加任务',
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
              Text('添加任务组'),
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
                        logic.addGroup(
                          GroupEntity.fromName(
                            name,
                          ),
                        );
                        // 你可以在这里执行保存操作等
                        Get.back();
                      },
                    );
                  },
                  child: Icon(Icons.add_card),
                );
              }),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: media.height * 0.04,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4.0,
          children: [
            ShadInputFormField(
              trailing: ShadButton(
                onPressed: () {
                  // TODO: Implement file picker functionality
                },
                width: 24,
                height: 24,
                padding: EdgeInsets.zero,
                decoration: const ShadDecoration(
                  secondaryBorder: ShadBorder.none,
                  secondaryFocusedBorder: ShadBorder.none,
                ),
                child: Icon(Icons.wheelchair_pickup),
              ),
              maxLines: null,
              minLines: 1,
              label: Text(
                'Todo文件保存路径',
                style: ShadTheme.of(context).textTheme.h4.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              placeholder: Text(
                '输入路径',
                style: ShadTheme.of(context).textTheme.p,
              ),
              style: ShadTheme.of(context).textTheme.p,
            ),
            ShadSelectFormField<String>(
              minWidth: 250,
              label: Text(
                '主题颜色',
                style: ShadTheme.of(context).textTheme.h4.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              initialValue: Get.find<MainControl>().theme,
              options: themes
                  .map(
                    (theme) => ShadOption(
                      value: theme,
                      child: Text(
                        theme,
                      ),
                    ),
                  )
                  .toList(),
              selectedOptionBuilder: (context, value) => value == 'none'
                  ? Text(
                      '选择你喜欢的主题',
                      style: ShadTheme.of(context).textTheme.p,
                    )
                  : Text(value),
              placeholder: Text(
                '选择你喜欢的主题',
                style: ShadTheme.of(context).textTheme.p,
              ),
              onChanged: (value) {
                Get.find<MainControl>().changeTheme(value!);
              },
            ),
            ShadSelectFormField<String>(
              minWidth: 250,
              label: Text(
                '主题模式',
                style: ShadTheme.of(context).textTheme.h4.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              initialValue: Get.find<MainControl>().themeMode.name,
              options: themeModes
                  .map(
                    (theme) => ShadOption(
                      value: theme,
                      child: Text(
                        theme,
                      ),
                    ),
                  )
                  .toList(),
              selectedOptionBuilder: (context, value) => value == 'none'
                  ? Text(
                      '选择你喜欢的主题',
                      style: ShadTheme.of(context).textTheme.p,
                    )
                  : Text(value),
              placeholder: Text(
                '选择你喜欢的主题',
                style: ShadTheme.of(context).textTheme.p,
              ),
              onChanged: (value) {
                Get.find<MainControl>().changeThemeMode(value!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
