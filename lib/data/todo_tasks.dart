import 'package:json_annotation/json_annotation.dart';
import 'package:aim/data/todo_task.dart';
part 'todo_tasks.g.dart';

@JsonSerializable()
class TodoTasks {
  String name;
  String uuid;
  List<TodoTask> todos;

  TodoTasks({required this.name, required this.uuid, required this.todos});

  factory TodoTasks.fromJson(Map<String, dynamic> json) =>
      _$TodoTasksFromJson(json);
  Map<String, dynamic> toJson() => _$TodoTasksToJson(this);
}
