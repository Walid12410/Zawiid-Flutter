import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';

Future<bool> updateUserDeleteChat(String id) async {
  final url = Uri.parse('${ApiEndpoints.localBaseUrl}/webChatRoom.php'); // Replace with your actual URL

  int isDeleted = 1;

  try {
    final response = await http.post(
      url,
      body: {
        'status': 'updateUserDelete',
        'id': id,
        'UserDelete': isDeleted.toString(),
      },
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody.containsKey('error')) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
