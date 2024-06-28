import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Classes/ColorAndMark/mark.dart';

Future<List<Mark>> fetchMarkById(int id) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/webMark.php?status=one&id=$id'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Mark> oneMark = jsonData.map((json) => Mark.fromJson(json)).toList();
      return oneMark;
    } else {
      throw Exception('Failed to load oneMark');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}
