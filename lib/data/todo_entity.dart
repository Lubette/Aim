import 'package:aim/generated/json/base/json_field.dart';
import 'package:aim/generated/json/todo_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class TodoEntity {
	String key = '';
	String todosKey = '';
	String description = '';
	String priority = '';
	String createdDate = '';
	String dueDate = '';
	String title = '';
	bool compeled = false;

	TodoEntity();

	factory TodoEntity.fromJson(Map<String, dynamic> json) => $TodoEntityFromJson(json);

	Map<String, dynamic> toJson() => $TodoEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}