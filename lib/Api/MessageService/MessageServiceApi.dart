import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:zawiid/core/config.dart';

import '../../model/ChatSupport/Message.dart';

class MessageService {


  Future<bool> sendMessage({
    required String chatRoomID,
    required String senderID,
    required String messageText,
  }) async {

    String sendAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    final url = Uri.parse('${ApiEndpoints.localBaseUrl}/ChatService/SendMessage.php');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'chatRoomID': chatRoomID.toString(),
      'senderID': senderID.toString(),
      'messageText': messageText.toString(),
      'sentAt': sendAt.toString(),
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['success'] == true) {
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception('Failed to send message');
    }
  }

    Future<List<Message>> fetchMessages(int chatRoomId) async {

    try {
      final response = await http.get(
        Uri.parse('${ApiEndpoints.localBaseUrl}/ChatService/FetchMessage.php?chatRoomID=$chatRoomId'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Message> message = jsonData.map((json) => Message.fromJson(json)).toList();
        return message;
      } else {
        throw Exception('Failed to load message');
      }
    } catch (e) {
      throw Exception('Server Error $e');
    }
  }
}
