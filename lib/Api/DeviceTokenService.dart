import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/core/config.dart';

class DeviceTokenService {
  Future<bool> addDeviceTokens({
    required int userNo,
    required String deviceTokens,
    required String deviceName,
  }) async {
    final url =
        Uri.parse('${ApiEndpoints.localBaseUrl}/webDeviceToken.php?status=new');

    try {
      final response = await http.post(
        url,
        body: {
          'UserID': userNo.toString(),
          'DeviceToken': deviceTokens.toString(),
          'DeviceName': deviceName.toString(),
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['message'] != null) {
          return false;
        } else {
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> checkDeviceName({
    required int userNo,
    required String deviceName,
  }) async {
    final url = Uri.parse(
        '${ApiEndpoints.localBaseUrl}/webDeviceToken.php?status=checkDeviceName');

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

  Future<bool> deleteDeviceToken({
    required int userNo,
    required String deviceName,
  }) async {
    final url = Uri.parse(
        '${ApiEndpoints.localBaseUrl}/webDeviceToken.php?status=delete');

    try {
      final response = await http.post(
        url,
        body: {
          'UserID': userNo.toString(),
          'DeviceName': deviceName,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['error'] != null) {
          return false;
        } else {
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateDeviceToken({
    required int userNo,
    required String deviceName,
  }) async {
    final url = Uri.parse(
        '${ApiEndpoints.localBaseUrl}/webDeviceToken.php?status=update');

    try {
      final response = await http.post(
        url,
        body: {
          'UserID': userNo.toString(),
          'DeviceName': deviceName,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['error'] != null) {
          return false;
        } else if (responseData['message'] != null) {
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
