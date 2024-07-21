import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';

Future<bool> checkDeviceName({
  required int userNo,
  required String deviceName,
}) async {
  final url = Uri.parse('${ApiEndpoints.localBaseUrl}/webDeviceToken.php?status=checkDeviceName');

  try {
    final response = await http.post(
      url,
      body: {
        'UserID': userNo.toString(),
        'DeviceName': deviceName.toString(),
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        return false;
      } else if (responseData['message'] != null) {
        return true;
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
