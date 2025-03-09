import 'package:aim/components/add_todo_page.dart';
import 'package:aim/components/task.dart';
import 'package:aim/controls/main_control.dart';
import 'package:aim/controls/use_hooks.dart';
import 'package:aim/data/todo_task.dart';
import 'package:aim/data/todo_tasks.dart';
import 'package:aim/views/todo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final media = useMediaQuery(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(
          media.size.height * 0.025,
        ),
        child: GetBuilder<MainControl>(
          builder: (logic) {
            return TodoView(
              todos: logic.today().$1.todos,
            );
          },
        ),
      ),
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
                    taskType: TodoTaskType.today,
                    selectEnable: false,
                    todosId: 'Today',
                    title: '添加任务',
                    todo: TodoTask(
                      id: '',
                      title: '',
                      startDate: DateTime.now().toString(),
                      description: '',
                    ),
                    firstPressed: (id, todo) {
                      print('sdaasd');
                      control.addTodoTask('Today', todo);
                      print('sdaasd');
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
                  child: Icon(Icons.add_card),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
