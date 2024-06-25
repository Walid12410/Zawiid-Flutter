import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Classes/GovArea/Governerate.dart';

Future<List<Governorate>> fetchAllGov() async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/webGoverment.php?status=select'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Governorate> governorate = jsonData.map((json) => Governorate.fromJson(json)).toList();
      return governorate;
    } else {
      throw Exception('Failed to load Governorate');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}
