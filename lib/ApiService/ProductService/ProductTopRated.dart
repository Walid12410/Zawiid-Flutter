import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Classes/Product/Products.dart';

Future<List<Product>> fetchProductTopRated() async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/mobileProductOperation.php?operation=random'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Product> productsTopRated = jsonData.map((json) => Product.fromJson(json)).toList();
      return productsTopRated;
    } else {
      throw Exception('Failed to load productsTopRated');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}
