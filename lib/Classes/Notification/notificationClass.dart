class Notifications {
  final int notificationId;
  final int userId;
  final String notificationTitle;
  final String notificationMessage;
  final DateTime sentAt;

  Notifications({
    required this.notificationId,
    required this.userId,
    required this.notificationTitle,
    required this.notificationMessage,
    required this.sentAt,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      notificationId: json['NotificationID'] ?? 0,
      userId: json['UserID'] ?? 0,
      notificationTitle: json['NotificationTitle'] ?? "",
      notificationMessage: json['NotificationMessage'] ?? "",
      sentAt: DateTime.parse(json['SentAt']['date']),
    );
  }
}
