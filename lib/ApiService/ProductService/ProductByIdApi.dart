import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Classes/Product/Products.dart';

Future<List<Product>> fetchProductById(int id) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/webProduct.php?status=one&id=$id'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Product> productsByID = jsonData.map((json) => Product.fromJson(json)).toList();
      return productsByID;
    } else {
      throw Exception('Failed to load Products');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}
