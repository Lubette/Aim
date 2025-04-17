import 'package:aim/generated/json/base/json_convert_content.dart';
import 'package:aim/data/group_entity.dart';

GroupEntity $GroupEntityFromJson(Map<String, dynamic> json) {
  final GroupEntity groupEntity = GroupEntity();
  final String? key = jsonConvert.convert<String>(json['key']);
  if (key != null) {
    groupEntity.key = key;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    groupEntity.description = description;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    groupEntity.name = name;
  }
  return groupEntity;
}

Map<String, dynamic> $GroupEntityToJson(GroupEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['key'] = entity.key;
  data['description'] = entity.description;
  data['name'] = entity.name;
  return data;
}

extension GroupEntityExtension on GroupEntity {
  GroupEntity copyWith({
    String? key,
    String? description,
    String? name,
  }) {
    return GroupEntity()
      ..key = key ?? this.key
      ..description = description ?? this.description
      ..name = name ?? this.name;
  }
}