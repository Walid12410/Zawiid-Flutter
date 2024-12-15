import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/Widget/Toast/ToastError.dart';
import 'package:zawiid/Widget/Toast/ToastSuccess.dart';
import 'package:zawiid/core/config.dart';
import 'package:zawiid/model/Notification/notificationClass.dart';

class NotificationService2 {
  Future<void> deleteAllNotifications(int userId) async {
    final url = Uri.parse(
        '${ApiEndpoints.localBaseUrl}/webNotifications.php'); // Replace with your PHP script URL

    try {
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
        showSucessToast("Notification deleted successfully!");
      } else {
        showToast("Something went wrong");
      }
    } catch (e) {
      showToast("Something went wrong");
    }
  }

  Future<List<Notifications>> fetchNotificationByUserID(int id) async {
    try {
      final response = await http.get(Uri.parse(
          '${ApiEndpoints.localBaseUrl}/webNotifications.php?status=byUserId&UserID=$id'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Notifications> allNotification =
            jsonData.map((json) => Notifications.fromJson(json)).toList();
        return allNotification;
      } else {
        throw Exception('Failed to load coupons Of  all Notification');
      }
    } catch (e) {
      throw Exception('Server Error');
    }
  }
}
