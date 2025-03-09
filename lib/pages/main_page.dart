import 'package:aim/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aim/components/navigation.dart';
import 'package:aim/components/navigation_item.dart';
import 'package:aim/controls/main_control.dart';
import 'package:aim/pages/settings_page.dart';
import 'package:aim/views/today_view.dart';

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
          NavigationItem(
            title: '今日任务',
            isSelected: selected == 0,
            content: HomePage(),
          ),
          ...buildItems(context),
          NavigationItem(
            title: '设置',
            isSelected: selected == Get.find<MainControl>().todos.length + 1,
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
    int count = 1;
    for (var todos in data) {
      list.add(NavigationItem(
        title: todos.name,
        isSelected: selected == count++,
        content: TodosView(title: todos.name, todos: todos.todos),
      ));
    }
    return list;
  }
}
