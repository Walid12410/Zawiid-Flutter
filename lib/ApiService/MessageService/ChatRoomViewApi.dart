import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import '../../Classes/ChatSupport/ChatRoom.dart';

Future<List<ChatRoom>> fetchChatRoom(int id) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/webChatRoom.php?status=byUser&UserID=$id'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<ChatRoom> userRoomChat = jsonData.map((json) => ChatRoom.fromJson(json)).toList();
      return userRoomChat;
    } else {
      throw Exception('Failed to load user room chat');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}
