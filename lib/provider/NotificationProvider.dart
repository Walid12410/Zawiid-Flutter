import 'package:flutter/cupertino.dart';
import 'package:zawiid/Api/NotificationService.dart';
import 'package:zawiid/model/Notification/notificationClass.dart';

class NotificationsProvider with ChangeNotifier {
  NotificationService2 service = NotificationService2();

  List<Notifications> _allNotification = [];
  List<Notifications> get allNotification => _allNotification;
  getAllNotifications(int id) async {
    final res = await service.fetchNotificationByUserID(id);
    _allNotification = res;
    notifyListeners();
  }

  void clearCart() {
    _allNotification.clear();
    notifyListeners();
  }
}
