class ChatRoom {
  final int chatRoomID;
  final String chatRoomTitle;
  final int userID;
  final int adminID;
  final DateTime createdAt;

  ChatRoom({
    required this.chatRoomID,
    required this.chatRoomTitle,
    required this.userID,
    required this.adminID,
    required this.createdAt,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      chatRoomID: json['ChatRoomID'] ?? 0,
      chatRoomTitle: json['ChatRoomTitle'] ?? "",
      userID: json['UserID'] ?? 0,
      adminID: json['AdminID'] ?? 0,
      createdAt: DateTime.parse(json['CreatedAt']['date']),
    );
  }
}