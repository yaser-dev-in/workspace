class TodoModel {
  int id;
  String title;
  bool isCompleted;
  String userId;

  TodoModel({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.userId,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
      userId: json['userId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
      'userId': userId,
    };
  }
}
