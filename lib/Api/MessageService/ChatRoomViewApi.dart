
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zawiid/core/config.dart';

import '../../model/ChatSupport/ChatRoom.dart';

Future<List<ChatRoom>> fetchChatRoomUser(int userID) async {

  try {
    final response = await http.get(
      Uri.parse('${ApiEndpoints.localBaseUrl}/webChatRoom.php?status=byUser&UserID=$userID'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<ChatRoom> chatRoom = jsonData.map((json) => ChatRoom.fromJson(json)).toList();
      return chatRoom;
    } else {
      throw Exception('Failed to load chat Room');
    }
  } catch (e) {
    throw Exception('Server Error $e');
  }
}
