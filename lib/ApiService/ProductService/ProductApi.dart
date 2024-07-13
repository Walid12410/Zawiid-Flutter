import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';

import '../../Classes/Product/ProductCategory.dart';

Future<List<ProductCategory>> fetchProductByCategoryNo(int id) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/mobileProductSubCategory.php?id=$id'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<ProductCategory> productsCategory = jsonData.map((json) => ProductCategory.fromJson(json)).toList();
      return productsCategory;
    } else {
      throw Exception('Failed to load products OF Category');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}
