import 'package:flutter/cupertino.dart';
import 'package:zawiid/ApiService/NotificationService/GetNotificationUser.dart';
import 'package:zawiid/Classes/Notification/notificationClass.dart';

class NotificationsProvider with ChangeNotifier {

  List<Notifications> _allNotification = [];
  List<Notifications> get allNotification => _allNotification;
  getAllNotifications( int id ) async {
    final res = await fetchNotificationByUserID(id);
    _allNotification = res;
    notifyListeners();
  }

  void clearCart() {
    _allNotification.clear();
    notifyListeners();
  }

}