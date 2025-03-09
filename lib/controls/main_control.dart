import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart' as Getx;
import 'package:aim/data/todo_task.dart';
import 'package:aim/data/todo_tasks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/data.dart';
import 'package:uuid/v8.dart';

class MainControl extends Getx.GetxController {
  ThemeMode themeMode = ThemeMode.system;
  String theme = 'zinc';
  List<TodoTasks> todos = [];
  TodoTasks _today = TodoTasks(name: 'Today', uuid: 'Today', todos: []);
  DateTime _todayDate = DateTime.now();

  void changeTheme(value) {
    theme = value;
    saveShared();
    update();
  }

  (TodoTasks, DateTime) today() {
    return (_today, _todayDate);
  }

  List<TodoTask> findTodos(String name) {
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
    prefs.setString(
      'Today',
      jsonEncode(_today.toJson()),
    );
    prefs.setString(
      'TodayTime',
      _todayDate.toIso8601String(),
    );
    prefs.setString(
      'Theme',
      theme,
    );
    prefs.setString(
      'ThemeMode',
      themeMode.name,
    );
    prefs.setStringList(
      'Todos',
      todos
          .map(
            (e) => jsonEncode(
              e.toJson(),
            ),
          )
          .toList()
          .cast<String>(),
    );
  }

  void loadShared() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _todayDate =
        DateTime.tryParse(prefs.getString('TodayTime') ?? "") ?? DateTime.now();
    if (prefs.getString("Today") == null) {
      _today = TodoTasks(name: '', uuid: '', todos: []);
    } else {
      _today = jsonDecode(prefs.getString("Today")!);
    }
    if (_todayDate.isBefore(DateTime.now().subtract(Duration(days: 1)))) {
      _todayDate = DateTime.now();
      _today = TodoTasks(name: '', uuid: '', todos: []);
    }
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
    todos = [];
    if (prefs.getStringList('Todos') != null) {
      todos = prefs
          .getStringList('Todos')!
          .map(
            (e) => TodoTasks.fromJson(
              jsonDecode(e),
            ),
          )
          .toList();
    }
    update();
  }

  void addTodoTasks(TodoTasks todotasks) {
    todos.add(todotasks);
    saveShared();
    update();
  }

  bool addTodoTask(String id, TodoTask todotask) {
    final index = todos.indexWhere((element) => element.uuid == id);
    if (id == 'Today') {
      print("asdas");
      _today.todos.add(todotask);
    } else if (index == -1) {
      return false;
    } else {
      todotask.id = generateTodoUniqueUUID();
      todos[index].todos.add(todotask);
    }
    update();
    saveShared();
    return true;
  }

  String generateTodoUniqueUUID() {
    UuidV8 v8 = UuidV8();
    String uuid;
    do {
      uuid = v8.generate();
    } while (
        todos.any((element) => element.todos.any((task) => task.id == uuid)));
    print("ID=$uuid");
    return uuid;
  }

  bool completedTodo(String id) {
    for (var todo in _today.todos) {
      if (todo.id == id) {
        todo.isCompleted = true;
        update();
        return true;
      }
    }
    for (var todoList in todos) {
      for (var todo in todoList.todos) {
        if (todo.id == id) {
          todo.isCompleted = true;
          update();
          return true;
        }
      }
    }
    return false;
  }

  String generateUniqueUUID() {
    UuidV8 v8 = UuidV8();
    String uuid;
    do {
      uuid = v8.generate(
          options: V8Options(DateTime.now(), List<int>.filled(16, 0)));
    } while (todos.any((element) => element.uuid == uuid));
    print("ID=$uuid");
    return uuid;
  }

  void removeTodoTask(String id) {
    for (var todoList in todos) {
      todoList.todos.removeWhere((todo) {
        print('${todo.id} == $id');
        return todo.id == id;
      });
    }
    update();
  }

  void updateTodoTask(TodoTask updatedTask) {
    for (var todoList in todos) {
      for (var i = 0; i < todoList.todos.length; i++) {
        if (todoList.todos[i].id == updatedTask.id) {
          todoList.todos[i] = updatedTask;
          update();
          return;
        }
      }
    }
  }
}

extension on (TodoTasks, DateTime) {
  set $1(DateTime $1) {}

  set $2(DateTime $2) {}
}
