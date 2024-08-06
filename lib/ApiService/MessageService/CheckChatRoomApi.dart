import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:zawiid/ApiEndPoint.dart';

Future<bool> checkChatFound(
    int userId,
    String chatRoomTitle) async {

  String apiUrl = "${ApiEndpoints.localBaseUrl}/ChatService/CheckChatRoom.php";
  String createAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'status': "new",
        'UserID': userId.toString(),
        'ChatRoomTitle': chatRoomTitle,
        'CreatedAt': createAt,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData.containsKey('message')) {
        return true;
      } else if (responseData.containsKey('error')) {
        return false;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
