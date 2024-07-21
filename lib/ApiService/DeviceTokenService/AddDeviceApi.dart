import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';

Future<bool> addDeviceTokens({
  required int userNo,
  required String deviceTokens,
  required String deviceName,
}) async {
  final url = Uri.parse('${ApiEndpoints.localBaseUrl}/webDeviceToken.php?status=new');

  try {
    final response = await http.post(
      url,
      body: {
        'UserID': userNo.toString(),
        'DeviceToken': deviceTokens.toString(),
        'DeviceName': deviceName.toString(),
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['message'] != null) {
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
