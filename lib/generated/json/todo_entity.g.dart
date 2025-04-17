import 'package:aim/generated/json/base/json_convert_content.dart';
import 'package:aim/data/todo_entity.dart';

TodoEntity $TodoEntityFromJson(Map<String, dynamic> json) {
  final TodoEntity todoEntity = TodoEntity();
  final String? key = jsonConvert.convert<String>(json['key']);
  if (key != null) {
    todoEntity.key = key;
  }
  final String? todosKey = jsonConvert.convert<String>(json['todosKey']);
  if (todosKey != null) {
    todoEntity.todosKey = todosKey;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    todoEntity.description = description;
  }
  final String? priority = jsonConvert.convert<String>(json['priority']);
  if (priority != null) {
    todoEntity.priority = priority;
  }
  final String? createdDate = jsonConvert.convert<String>(json['createdDate']);
  if (createdDate != null) {
    todoEntity.createdDate = createdDate;
  }
  final String? dueDate = jsonConvert.convert<String>(json['dueDate']);
  if (dueDate != null) {
    todoEntity.dueDate = dueDate;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    todoEntity.title = title;
  }
  final bool? compeled = jsonConvert.convert<bool>(json['compeled']);
  if (compeled != null) {
    todoEntity.compeled = compeled;
  }
  return todoEntity;
}

Map<String, dynamic> $TodoEntityToJson(TodoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['key'] = entity.key;
  data['todosKey'] = entity.todosKey;
  data['description'] = entity.description;
  data['priority'] = entity.priority;
  data['createdDate'] = entity.createdDate;
  data['dueDate'] = entity.dueDate;
  data['title'] = entity.title;
  data['compeled'] = entity.compeled;
  return data;
}

extension TodoEntityExtension on TodoEntity {
  TodoEntity copyWith({
    String? key,
    String? todosKey,
    String? description,
    String? priority,
    String? createdDate,
    String? dueDate,
    String? title,
    bool? compeled,
  }) {
    return TodoEntity()
      ..key = key ?? this.key
      ..todosKey = todosKey ?? this.todosKey
      ..description = description ?? this.description
      ..priority = priority ?? this.priority
      ..createdDate = createdDate ?? this.createdDate
      ..dueDate = dueDate ?? this.dueDate
      ..title = title ?? this.title
      ..compeled = compeled ?? this.compeled;
  }
}