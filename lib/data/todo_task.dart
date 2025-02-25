import 'package:json_annotation/json_annotation.dart';
part 'todo_task.g.dart';

// 优先级枚举
enum PriorityLevel {
  @JsonValue(0)
  low,
  @JsonValue(1)
  normal,
  @JsonValue(2)
  high,
  @JsonValue(3)
  urgent,
}

@JsonSerializable()
class TodoTask {
  String id;

  String title;
  String description;
  bool isCompleted;
  String startDate;
  String? dueDate; // 可空的截止日期
  String? completedDate; // 可空的截止日期
  PriorityLevel priority; // 优先级

  TodoTask({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.startDate,
    this.dueDate,
    this.completedDate,
    this.priority = PriorityLevel.normal,
  });

  // 返回任务的优先级字符串
  String getPriorityString() {
    switch (priority) {
      case PriorityLevel.low:
        return '低';
      case PriorityLevel.normal:
        return '普通';
      case PriorityLevel.high:
        return '高';
      case PriorityLevel.urgent:
        return '紧急';
    }
  }

  // 检查任务是否过期
  bool isOverdue() {
    if (dueDate == null) return false; // 如果没有截止日期，不算过期
    return DateTime.parse(dueDate!).isBefore(DateTime.now());
  }

  // 标记任务为完成
  void markAsCompleted() {
    isCompleted = true;
  }

  // 标记任务为未完成
  void markAsUncompleted() {
    isCompleted = false;
  }

  // 设置截止日期
  void setDueDate(DateTime? date) {
    dueDate = date?.toIso8601String();
  }

  // 更新任务描述
  void updateDescription(String newDescription) {
    description = newDescription;
  }

  // 更新任务标题
  void updateTitle(String newTitle) {
    title = newTitle;
  }

  factory TodoTask.fromJson(Map<String, dynamic> json) =>
      _$TodoTaskFromJson(json);

  Map<String, dynamic> toJson() => _$TodoTaskToJson(this);
}

// 任务类型
enum TodoTaskType {
  normal,
  today,
  custom,
}
