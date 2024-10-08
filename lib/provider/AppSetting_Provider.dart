import 'package:flutter/material.dart';
import 'package:zawiid/Api/SettingAppService.dart';
import '../model/AppSetting.dart';

class SettingsProvider extends ChangeNotifier {
  SettingAppService settingService = SettingAppService();

  List<Setting> _settings = [];
  List<Setting> get settings => _settings;

  Future<void> loadSettings() async {
    _settings = await settingService.fetchSettings();
    notifyListeners();
  }
}
