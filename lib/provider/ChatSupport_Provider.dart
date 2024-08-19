import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:zawiid/ApiService/MessageService/ChatRoomViewApi.dart';
import 'package:zawiid/Classes/ChatSupport/ChatRoom.dart';
import '../ApiService/MessageService/MessageServiceApi.dart';
import '../Classes/ChatSupport/Message.dart';

class ChatSupportProvider with ChangeNotifier {


  List<ChatRoom> _chatRoom = [];
  List<ChatRoom> get chatRoom => _chatRoom;

  getChatRoom(int id) async {
    final res = await fetchChatRoomUser(id);
    _chatRoom = res;
    notifyListeners();
  }


  final List<Message> _messages = [];

  List<Message> get messages => _messages;

  addNewMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }


// List<Message> _messages = [];
  // List<Message> get messages => _messages;
  //
  // Timer? _timer;
  //
  // final MessageService _messageService = MessageService();
  //
  //
  //
  // void startFetchingMessages(int chatRoomId) {
  //   _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
  //     await fetchMessages(chatRoomId);
  //   });
  // }
  //
  // void stopFetchingMessages() {
  //   _timer?.cancel();
  // }
  //
  // Future<void> fetchMessages(int chatRoomId) async {
  //   try {
  //     final List<Message> fetchedMessages = await _messageService.fetchMessages(chatRoomId);
  //
  //     if (fetchedMessages.isNotEmpty) {
  //       _messages = [..._messages, ...fetchedMessages.where((msg) => !_messages.any((m) => m.messageId == msg.messageId))];
  //       _messages.sort((a, b) => b.sentAt.compareTo(a.sentAt));
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
  //
  // Future<void> sendMessage(int chatRoomId, int senderId, String messageText) async {
  //   try {
  //     await _messageService.sendMessage(chatRoomID: chatRoomId.toString(), senderID: senderId.toString(), messageText: messageText);
  //     await fetchMessages(chatRoomId);
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
  //
  // @override
  // void dispose() {
  //   _timer?.cancel();
  //   super.dispose();
  // }
}
