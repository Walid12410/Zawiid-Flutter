import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/ApiService/DeviceTokenService/AddDeviceApi.dart';
import 'package:zawiid/ApiService/DeviceTokenService/CheckDeviceApi.dart';
import 'package:zawiid/ApiService/DeviceTokenService/UpdateDeviceApi.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import '../DeviceName/DeviceName.dart';
import 'package:synchronized/synchronized.dart';

// Handle background messages
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('title: ${message.notification?.title}');
  print('body: ${message.notification?.body}');
  print('payload: ${message.data}');
}

class FirebaseApi {
  final _firebaseMessage = FirebaseMessaging.instance;
  final _lock = Lock();

  Future<void> initNotifications(BuildContext context) async {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    await _firebaseMessage.requestPermission();
    final fCMToken = await _firebaseMessage.getToken();
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    String deviceName = await DeviceInfoHelper.getDeviceInfo();

    try {
      if (auth.userId != 0 && deviceName != "Unknown") {
        await _lock.synchronized(() async {
          bool checkIfFound = await checkDeviceName(
              userNo: auth.userId, deviceName: deviceName);
          if (checkIfFound) {
            await updateDeviceToken(
                userNo: auth.userId, deviceName: deviceName);
          } else {
            await addDeviceTokens(
                userNo: auth.userId,
                deviceTokens: fCMToken.toString(),
                deviceName: deviceName);
          }
        });
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}