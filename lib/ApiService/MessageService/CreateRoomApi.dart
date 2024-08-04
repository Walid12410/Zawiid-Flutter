import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:zawiid/ApiEndPoint.dart';

Future<bool> createRoomChat({
  required String chatRoomTitle,
  required int userID,
}) async {
  final url = Uri.parse('${ApiEndpoints.localBaseUrl}/webChatRoom.php?status=new');
  String createDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  try {
    final response = await http.post(
      url,
      body: {
        'status': 'new',
        'ChatRoomTitle': chatRoomTitle.toString(),
        'UserID': userID.toString(),
        'CreatedAt': createDate.toString(),
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['message'] != null) {
        return true;
      } else if (responseData['error'] != null) {
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
