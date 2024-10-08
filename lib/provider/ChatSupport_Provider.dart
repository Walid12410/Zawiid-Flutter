import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:zawiid/Api/MessageService/ChatRoomViewApi.dart';
import 'package:zawiid/model/ChatSupport/ChatRoom.dart';
import '../Api/MessageService/MessageServiceApi.dart';
import '../model/ChatSupport/Message.dart';

class ChatSupportProvider with ChangeNotifier {


  List<ChatRoom> _chatRoom = [];
  List<ChatRoom> get chatRoom => _chatRoom;

  getChatRoom(int id) async {
    final res = await fetchChatRoomUser(id);
    _chatRoom = res;
    notifyListeners();
  }



List<Message> _messagesHistory = [];
  List<Message> get messagesHistory => _messagesHistory;


  final MessageService _messageService = MessageService();


  Future<void> fetchMessages(int chatRoomId) async {
    try {
      final List<Message> fetchedMessages = await _messageService.fetchMessages(chatRoomId);
      if (fetchedMessages.isNotEmpty) {
        _messagesHistory = [..._messagesHistory, ...fetchedMessages.where((msg) => !_messagesHistory.any((m) => m.messageId == msg.messageId))];
        _messagesHistory.sort((a, b) => a.sentAt.compareTo(b.sentAt));
        notifyListeners();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> sendMessage(int chatRoomId, int senderId, String messageText) async {
    try {
      await _messageService.sendMessage(chatRoomID: chatRoomId.toString(), senderID: senderId.toString(), messageText: messageText);
    } catch (e) {
      throw Exception(e);
    }
  }
}
