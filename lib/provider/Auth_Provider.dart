import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zawiid/Api/DeviceTokenService.dart';
import 'package:zawiid/core/DeviceName/DeviceName.dart';

class AuthProvider with ChangeNotifier {
  DeviceTokenService deviceService = DeviceTokenService();

  bool _isLoggedIn = false;
  int _userId = 0;

  bool get isLoggedIn => _isLoggedIn;
  int get userId => _userId;

  void setUserId(int userId) {
    _userId = userId;
    notifyListeners();
  }

  AuthProvider() {
    _loadFromPrefs();
  }

  void _loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLogIn') ?? false;
    notifyListeners();
  }

  Future<void> logout() async {
    String deviceName = await DeviceInfoHelper.getDeviceInfo();
    await deviceService.deleteDeviceToken(
        userNo: _userId, deviceName: deviceName);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogIn', false);
    await prefs.setInt('userID', 0);
    _isLoggedIn = false;
    _userId = 0;
    notifyListeners();
  }
}
