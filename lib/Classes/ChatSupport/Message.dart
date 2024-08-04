class Message {
  final int messageId;
  final int chatRoomId;
  final int senderId;
  final String messageText;
  final DateTime sentAt;

  Message({
    required this.messageId,
    required this.chatRoomId,
    required this.senderId,
    required this.messageText,
    required this.sentAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      messageId: json['MessageID'] ?? 0,
      chatRoomId: json['ChatRoomID'] ?? 0,
      senderId: json['SenderID'] ?? 0,
      messageText: json['MessageText'] ?? "",
      sentAt:DateTime.parse(json['SentAt']['date']) ,
    );
  }
}
