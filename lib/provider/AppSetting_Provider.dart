import 'package:flutter/material.dart';

import '../ApiService/SettingApp.dart';
import '../Classes/AppSetting.dart';

class SettingsProvider extends ChangeNotifier {
  List<Setting> _settings = [];

  List<Setting> get settings => _settings;

  Future<void> loadSettings() async {
    ApiService apiService = ApiService();
    _settings = await apiService.fetchSettings();
    notifyListeners();
  }
}
