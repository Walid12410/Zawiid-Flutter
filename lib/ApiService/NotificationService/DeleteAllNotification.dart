import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';

Future<void> deleteAllNotifications(int userId) async {
  final url = Uri.parse('${ApiEndpoints.localBaseUrl}/webNotifications.php'); // Replace with your PHP script URL

  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: <String, String>{
      'status': 'deleteAllByUserId',
      'UserID': userId.toString(),
    },
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    if (responseData.containsKey('error')) {
      print('Error: ${responseData['error']}');
    } else if (responseData.containsKey('message')) {
      print('Message: ${responseData['message']}');
    }
  } else {
    print('Failed to delete notifications. Status code: ${response.statusCode}');
  }
}
