import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import '../../Classes/Categories/Category.dart';

Future<List<Categories>> fetchCategories() async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/MobileApi/mobileCategory.php'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Categories> categories = jsonData.map((json) => Categories.fromJson(json)).toList();
      return categories;
    } else {
      throw Exception('Failed to load Categories');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}
