import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Classes/GovArea/Area.dart';

Future<List<Area>> fetchAllArea() async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/webArea.php?status=select'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Area> area = jsonData.map((json) => Area.fromJson(json)).toList();
      return area;
    } else {
      throw Exception('Failed to load Governorate');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}
