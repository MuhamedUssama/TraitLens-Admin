class NotificationModel {
  final String? id;
  final String? title;
  final String? message;
  bool? isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    this.isRead = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      isRead: json['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'message': message, 'isRead': isRead};
  }
}
