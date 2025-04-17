import 'dart:convert';

import 'package:aim/data/group_entity.dart';
import 'package:aim/data/todo_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/v8.dart';

class MainControl extends getx.GetxController {
  ThemeMode themeMode = ThemeMode.system;
  String theme = 'zinc';
  List<GroupEntity> groups = [];
  Map<String, TodoEntity> todos = {};

  void changeTheme(value) {
    theme = value;
    saveShared();
    update();
  }

  List<GroupEntity> findTodos(String name) {
    // Add implementation or throw an exception
    return [];
  }

  void changeThemeMode(String value) {
    switch (value) {
      case 'dark':
        themeMode = ThemeMode.dark;
        break;
      case 'light':
        themeMode = ThemeMode.light;
        break;
      case 'system':
        themeMode = ThemeMode.system;
        break;
    }
    saveShared();
    update();
  }

  void saveShared() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString(
    //   'Today',
    //   jsonEncode(_today.toJson()),
    // );
    // prefs.setString(
    //   'TodayTime',
    //   _todayDate.toIso8601String(),
    // );
    prefs.setString(
      'Theme',
      theme,
    );
    prefs.setString(
      'ThemeMode',
      themeMode.name,
    );
    prefs.setString(
      'Groups',
      jsonEncode(
        groups.map((ele) => ele.toJson()).cast().toList(),
      ),
    );
    prefs.setStringList(
      "Todos",
      todos.values
          .map((ele) => ele.toJson())
          .map((ele) => jsonEncode(ele))
          .toList(),
    );
  }

  void loadShared() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // _todayDate =
    //     DateTime.tryParse(prefs.getString('TodayTime') ?? "") ?? DateTime.now();
    //
    // debugPrint("${prefs.getString("Today")}");
    // if (prefs.getString("Today") == null) {
    //   _today = TodoTasks(name: '', uuid: '', groups: []);
    // } else {
    //   _today = TodoTasks.fromJson(jsonDecode(prefs.getString("Today")!));
    // }
    // if (_todayDate.isBefore(DateTime.now().subtract(Duration(days: 1)))) {
    //   _todayDate = DateTime.now();
    //   _today = TodoTasks(name: '', uuid: '', groups: []);
    // }
    theme = prefs.getString(
          'Theme',
        ) ??
        'zinc';
    themeMode = ThemeMode.values.byName(
      prefs.getString(
            'ThemeMode',
          ) ??
          'system',
    );
    groups = [];
    todos = {};
    if (prefs.getStringList('Todos') != null) {
      for (var e in prefs.getStringList('Todos')!) {
        final todo = TodoEntity.fromJson(
          jsonDecode(e),
        );
        todos[todo.key] = todo;
      }
    }
    update();
  }

  void addGroup(GroupEntity group) {
    group.key = generateUniqueUUID();
    groups.add(group);
    saveShared();
    update();
  }

  bool addTodoTask(String id, TodoEntity todo) {
    todo.key = generateTodoUniqueUUID();
    todos[todo.key] = todo;
    update();
    saveShared();
    return true;
  }

  String generateTodoUniqueUUID() {
    UuidV8 v8 = UuidV8();
    String uuid;
    do {
      uuid = v8.generate();
    } while (todos[uuid] != null);
    debugPrint("ID=$uuid");
    return uuid;
  }

  void completedTodo(String id) {
    todos[id]?.compeled = true;
  }

  String generateUniqueUUID() {
    UuidV8 v8 = UuidV8();
    String uuid;
    do {
      uuid = v8.generate();
    } while (groups.any((element) => element.key == uuid));
    return uuid;
  }

  void removeTodoTask(String id) {
    todos.remove(id);
    update([id]);
  }

  void updateTodoTask(TodoEntity todo) {
    todos[todo.key] != null ? todos[todo.key] = todo : todo;
  }
}
