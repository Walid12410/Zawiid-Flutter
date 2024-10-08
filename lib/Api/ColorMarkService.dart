import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/core/config.dart';
import 'package:zawiid/model/ColorAndMark/color.dart';
import 'package:zawiid/model/ColorAndMark/mark.dart';



class ColorMarkService {
  Future<List<ColorProduct>> fetchColorById(int id) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/webColor.php?status=one&ColorNo=$id'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<ColorProduct> oneColor = jsonData.map((json) => ColorProduct.fromJson(json)).toList();
      return oneColor;
    } else {
      throw Exception('Failed to load oneColor');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}

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

}