import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:lubette_todo_flutter/components/navigation.dart';
import 'package:lubette_todo_flutter/components/navigation_item.dart';
import 'package:lubette_todo_flutter/controls/main_control.dart';
import 'package:lubette_todo_flutter/pages/settings_page.dart';
import 'package:lubette_todo_flutter/views/today_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigation(
        items: [
          ...buildItems(context),
          NavigationItem(
            title: '设置',
            isSelected: selected == Get.find<MainControl>().todos.length,
            content: SettingsPage(),
          ),
        ],
        onItemTap: (index) {
          setState(() => selected = index);
          debugPrint('$index');
        },
        selected: selected,
      ),
    );
  }

  List<NavigationItem> buildItems(BuildContext context) {
    final data = Get.find<MainControl>().todos;
    final list = <NavigationItem>[];
    int count = 0;
    for (var todos in data) {
      list.add(NavigationItem(
        title: todos.name,
        isSelected: selected == count,
        content: TodosView(title: todos.name, todos: todos.todos),
      ));
    }
    return list;
  }
}
