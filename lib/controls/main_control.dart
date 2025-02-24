import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:lubette_todo_flutter/data/todo_task.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/data.dart';
import 'package:uuid/v8.dart';

class MainControl extends GetxController {
  Map<String, List<TodoTask>> todos = {};

  Map<String, String> todoNames = {'today': 'today'};

  void addTodayTodo(TodoTask task) {
    if (todos['today'] == null) {
      todos['today'] = [];
    }
    todos['today'] = [...todos['today']!, task];
    update();
    save();
  }

  void createTodoList(String name) {
    final uuid = generatTodosUUID(UuidV8());
    if (todos[uuid] == null) {
      todos[uuid] = [];
    }
    todoNames[uuid] = name;
    update();
    save();
  }

  String generatTodosUUID(UuidV8 uuid) {
    final id = uuid.generate(
      options: V8Options(
        DateTime.now(),
        null,
      ),
    );
    for (var element in todos.entries) {
      if (element.key == id) {
        return generatTodosUUID(uuid);
      }
    }
    return id;
  }

  void addCustomTodo(String uuid, TodoTask task) {
    if (todos[uuid] == null) {
      todos[uuid] = [];
    }
    todos[uuid] = [...todos[uuid]!, task];
    update();
    save();
  }

  List<TodoTask>? todayTodo() {
    var _todos = <TodoTask>[];
    final time = DateTime.now();
    final before = DateTime(time.year, time.month, time.day);
    if (todos['today'] == null) {
      return [];
    }
    for (var element in todos['today']!) {
      if (element.isCompleted) {
        if (element.completedDate != null) {
          if (element.completedDate!.isBefore(before)) {
            element.isCompleted = true;
          }
        }
      }
      _todos = [..._todos, element];
    }
    return _todos;
  }

  List<TodoTask>? uuidTodo(String uuid) {
    return todos[uuid];
  }

  void setTodo(TodoTask todo) {
    for (var element in todos.entries) {
      for (var item in element.value) {
        if (item.id == todo.id) {
          element.value.remove(item);
          element.value.add(item);
          update();
          save();
          return;
        }
      }
    }
  }

  void load() async {
    try {
      // 获取应用的文档目录
      final appDocumentsDirectory = await getApplicationDocumentsDirectory();
      final todosFilePath = path.join(appDocumentsDirectory.path, 'todos.json');

      // 检查文件是否存在
      final file = File(todosFilePath);
      if (!file.existsSync()) {
        print("File does not exist: $todosFilePath");
        return;
      }

      // 读取文件内容
      final fileContent = await file.readAsString();
      final todosJson = jsonDecode(fileContent) as Map<String, dynamic>;

      // 解析 JSON 数据并更新 todos 和 todoNames
      todos.clear(); // 清空现有数据
      todoNames.clear();

      for (final entry in todosJson.entries) {
        final listKey = entry.key;
        final listData = entry.value as Map<String, dynamic>;
        final listName = listData['name'] as String;
        final todosJsonList = listData['todos'] as List<dynamic>;

        // 将 JSON 数据转换为 TodoTask 列表
        final todoList =
            todosJsonList.map((task) => TodoTask.fromJson(task)).toList();

        // 更新 todos 和 todoNames
        todos[listKey] = todoList;
        todoNames[listKey] = listName;
      }
      update();

      // 打印加载成功信息
      print("Todos loaded from file: $todosFilePath");
    } catch (e) {
      // 捕获异常并打印错误信息
      print("Error loading todos: $e");
    }
  }

  void save() async {
    // 获取应用的文档目录
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    final todosFilePath = path.join(appDocumentsDirectory.path, 'todos.json');

    // 创建一个 Map 来存储 JSON 数据
    final Map<String, dynamic> todosJson = {};

    // 遍历 todos 和 todoNames，将数据转换为 JSON 格式
    for (final entry in todos.entries) {
      final listKey = entry.key;
      final todosList = entry.value;

      // 确保 todoNames 有对应的键
      final listName = todoNames[listKey] ?? 'Unnamed List';

      // 将 TodoTask 转换为 JSON 格式
      final todosJsonList = todosList.map((task) => task.toJson()).toList();

      // 将数据存入 todosJson
      todosJson[listKey] = {
        'name': listName,
        'todos': todosJsonList,
      };
    }

    // 将 Map 转换为 JSON 字符串
    final jsonContent = jsonEncode(todosJson);

    // 写入文件
    final file = File(todosFilePath);
    await file.writeAsString(jsonContent);

    // 打印保存成功信息
    print("Todos saved to file: $todosFilePath");
  }

  bool completed(String uuid) {
    for (var element in todos.entries) {
      for (var item in element.value) {
        if (item.id == uuid) {
          item.isCompleted = true;
          update();
          return true;
        }
      }
    }
    return false;
  }

  void removeTodo(String uuid) {
    for (var element in todos.entries) {
      element.value.removeWhere(
        (element) {
          if (element.id == uuid) {
            update();
            save();
            return true;
          }
          return false;
        },
      );
    }
  }

  String generateTodoUUID(UuidV8 uuid) {
    final id = uuid.generate(
      options: V8Options(
        DateTime.now(),
        null,
      ),
    );
    for (var element in todos.entries) {
      if (element.value.firstWhereOrNull(
            (element) => element.id == id,
          ) !=
          null) {
        return generateTodoUUID(uuid);
      }
    }
    return id;
  }
}
