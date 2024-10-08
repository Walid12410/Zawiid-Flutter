import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/core/config.dart';
import 'package:zawiid/model/GovArea/Area.dart';
import 'package:zawiid/model/GovArea/Governerate.dart';

class GovAreaService{
  
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

}