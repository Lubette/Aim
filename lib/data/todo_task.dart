class TodoTask {
  String id;
  String title;
  String description;
  bool isCompleted;
  DateTime startDate;
  DateTime? dueDate; // 可空的截止日期
  DateTime? completedDate; // 可空的截止日期
  PriorityLevel priority; // 优先级
  List<String> tags; // 标签列表

  // 构造函数
  TodoTask({
    required this.id,
    required this.title,
    required this.startDate,
    this.description = '', // 默认为空字符串
    this.isCompleted = false, // 默认未完成
    this.dueDate, // 可以为空
    this.priority = PriorityLevel.normal, // 默认普通优先级
    this.tags = const [], // 默认为空标签列表
    this.completedDate,
  });

  // 将对象转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'startDate': startDate.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'priority': priority.name,
      'tags': tags,
      'completedDate': completedDate?.toIso8601String(),
    };
  }

  // 从 JSON 创建对象
  factory TodoTask.fromJson(Map<String, dynamic> json) {
    return TodoTask(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
      startDate: DateTime.parse(json['startDate']),
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
      completedDate: json['completedDate'] != null
          ? DateTime.parse(json['completedDate'])
          : null,
      priority: PriorityLevel.values.byName(json['priority'] ?? 'normal'),
      tags: List<String>.from(json['tags'] ?? []),
    );
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
    dueDate = date;
  }

  // 添加标签
  void addTag(String tag) {
    if (!tags.contains(tag)) {
      tags.add(tag);
    }
  }

  // 移除标签
  void removeTag(String tag) {
    tags.remove(tag);
  }

  // 更新任务标题
  void updateTitle(String newTitle) {
    title = newTitle;
  }

  // 更新任务描述
  void updateDescription(String newDescription) {
    description = newDescription;
  }

  // 检查任务是否过期
  bool isOverdue() {
    if (dueDate == null) return false; // 如果没有截止日期，不算过期
    return dueDate!.isBefore(DateTime.now());
  }

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
}

// 优先级枚举
enum PriorityLevel {
  low,
  normal,
  high,
  urgent,
}

// 任务类型
enum TodoTaskType {
  normal,
  today,
  custom,
}
