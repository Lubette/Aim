// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_tasks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoTasks _$TodoTasksFromJson(Map<String, dynamic> json) => TodoTasks(
      name: json['name'] as String,
      uuid: json['uuid'] as String,
      todos: (json['todos'] as List<dynamic>)
          .map((e) => TodoTask.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TodoTasksToJson(TodoTasks instance) => <String, dynamic>{
      'name': instance.name,
      'uuid': instance.uuid,
      'todos': instance.todos,
    };
