// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoTask _$TodoTaskFromJson(Map<String, dynamic> json) => TodoTask(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      startDate: json['startDate'] as String,
      dueDate: json['dueDate'] as String?,
      completedDate: json['completedDate'] as String?,
      priority: $enumDecodeNullable(_$PriorityLevelEnumMap, json['priority']) ??
          PriorityLevel.normal,
    );

Map<String, dynamic> _$TodoTaskToJson(TodoTask instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'isCompleted': instance.isCompleted,
      'startDate': instance.startDate,
      'dueDate': instance.dueDate,
      'completedDate': instance.completedDate,
      'priority': _$PriorityLevelEnumMap[instance.priority]!,
    };

const _$PriorityLevelEnumMap = {
  PriorityLevel.low: 0,
  PriorityLevel.normal: 1,
  PriorityLevel.high: 2,
  PriorityLevel.urgent: 3,
};
