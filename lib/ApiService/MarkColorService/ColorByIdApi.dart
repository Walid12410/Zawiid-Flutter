import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import '../../Classes/ColorAndMark/color.dart';

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
