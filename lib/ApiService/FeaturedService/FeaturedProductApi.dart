import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Classes/Featured/Featured.dart';

Future<List<Featured>> fetchFeaturedProducts() async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/MobileApi/mobileFeature.php'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Featured> featuredProduct = jsonData.map((json) => Featured.fromJson(json)).toList();
      return featuredProduct;
    } else {
      throw Exception('Failed to load featuredProduct');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}
