import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class DeviceInfoHelper {
  static Future<String> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceName = "Unknown";

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceName = androidInfo.id + androidInfo.board + androidInfo.fingerprint;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceName = iosInfo.utsname.machine;
      }
    } catch (e) {
      throw Exception(e);
    }

    return deviceName;
  }
}
