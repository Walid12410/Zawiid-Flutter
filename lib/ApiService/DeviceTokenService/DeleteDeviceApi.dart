import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';

Future<bool> deleteDeviceToken({
  required int userNo,
  required String deviceName,
}) async {
  final url = Uri.parse('${ApiEndpoints.localBaseUrl}/webDeviceToken.php?status=delete');

  try {
    final response = await http.post(
      url,
      body: {
        'UserID': userNo.toString(),
        'DeviceName': deviceName,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
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
