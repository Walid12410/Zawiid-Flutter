import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';

import '../../Classes/Notification/notificationClass.dart';

Future<List<Notifications>> fetchNotificationByUserID(int id) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/webNotifications.php?status=byUserId&UserID=$id'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Notifications> allNotification = jsonData.map((json) => Notifications.fromJson(json)).toList();
      return allNotification;

    } else {
      throw Exception('Failed to load coupons Of  all Notification');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}
