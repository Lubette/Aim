import 'package:aim/generated/json/base/json_field.dart';
import 'package:aim/generated/json/group_entity.g.dart';
import 'dart:convert';
export 'package:aim/generated/json/group_entity.g.dart';

@JsonSerializable()
class GroupEntity {
  String key = '';
  String description = '';
  String name = '';

  GroupEntity();

  factory GroupEntity.fromJson(Map<String, dynamic> json) =>
      $GroupEntityFromJson(json);

  Map<String, dynamic> toJson() => $GroupEntityToJson(this);

  factory GroupEntity.fromName(String name) {
    final group = GroupEntity();
    group.name = name;
    return group;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
