import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:lubette_todo_flutter/components/navigation.dart';
import 'package:lubette_todo_flutter/components/navigation_item.dart';
import 'package:lubette_todo_flutter/controls/main_control.dart';
import 'package:lubette_todo_flutter/views/today_view.dart';

class MainPage extends HookWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selected = useState(0);
    return Scaffold(
      body: Navigation(
        items: [
          NavigationItem(
            title: '今日',
            isSelected: selected.value == 0,
            content: GetBuilder<MainControl>(
              builder: (logic) => TodosView(
                title: 'Today',
                todos: logic.todayTodo()!,
              ),
            ),
          ),
          NavigationItem(
            title: '任务',
            isSelected: selected.value == 1,
            content: TodosView(
              title: 'Tasks',
              todos: Get.find<MainControl>().todos['tasks'] ?? [],
            ),
          ),
          NavigationItem(
            title: '设置',
            isSelected: selected.value == 2,
            content: Center(
              child: Text(
                'Settings',
              ),
            ),
          ),
        ],
        onItemTap: (index) {
          selected.value = index;
          debugPrint('$index');
        },
        selected: selected.value,
      ),
    );
  }
}
