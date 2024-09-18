import 'dart:convert';

import 'package:zawiid/ApiEndPoint.dart';

import '../Classes/AppSetting.dart';
import 'package:http/http.dart' as http;


class ApiService {

  Future<List<Setting>> fetchSettings() async {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/webTbSettings.php?status=select'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Setting.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load settings');
    }
  }
}
