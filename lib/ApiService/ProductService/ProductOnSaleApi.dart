import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Classes/Product/Products.dart';

Future<List<Product>> fetchProductOnSale() async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/MobileApi/mobileProductOperation.php?operation=topDiscounted'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Product> productsOnSale = jsonData.map((json) => Product.fromJson(json)).toList();
      return productsOnSale;
    } else {
      throw Exception('Failed to load productsOnSale');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}
