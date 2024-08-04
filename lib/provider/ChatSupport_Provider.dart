import 'dart:async';
import 'package:flutter/foundation.dart';
import '../ApiService/MessageService/ChatRoomViewApi.dart';
import '../ApiService/MessageService/MessageServiceApi.dart';
import '../Classes/ChatSupport/Message.dart';
import '../Classes/ChatSupport/ChatRoom.dart';

class ChatSupportProvider with ChangeNotifier {
  List<ChatRoom> _allChatRoom = [];
  List<ChatRoom> get allChatRoom => _allChatRoom;

  List<Message> _messages = [];
  List<Message> get messages => _messages;

  Timer? _timer;

  final MessageService _messageService = MessageService();


  Future<void> getAllChatRoom(int id) async {
    try {
      _allChatRoom = await fetchChatRoom(id);
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }
  void removeFromChatRoom(int id) {
    _allChatRoom.removeWhere((chat) => chat.chatRoomID == id);
    notifyListeners();
  }

  void startFetchingMessages(int chatRoomId) {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await fetchMessages(chatRoomId);
    });
  }

  void stopFetchingMessages() {
    _timer?.cancel();
  }

  Future<void> fetchMessages(int chatRoomId) async {
    try {
      final List<Message> fetchedMessages = await _messageService.fetchMessages(chatRoomId);

      if (fetchedMessages.isNotEmpty) {
        fetchedMessages.sort((a, b) => b.sentAt.compareTo(a.sentAt));
        _messages.removeWhere((msg) => fetchedMessages.any((fetchedMsg) => fetchedMsg.messageId == msg.messageId));
        _messages.addAll(fetchedMessages);
        notifyListeners();
      }
    } catch (e) {
      throw Exception(e);
    }
  }


  Future<void> sendMessage(int chatRoomId, int senderId, String messageText) async {
    try {
      await _messageService.sendMessage(chatRoomID: chatRoomId.toString(), senderID: senderId.toString(), messageText: messageText);
      await fetchMessages(chatRoomId);
    } catch (e) {
     throw Exception(e);
    }
  }

  void addMessage(Message message) {
    int index = _messages.indexWhere((m) => m.sentAt.isBefore(message.sentAt));
    if (index == -1) {
      _messages.add(message);
    } else {
      _messages.insert(index, message);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
