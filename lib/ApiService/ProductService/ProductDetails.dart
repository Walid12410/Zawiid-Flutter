import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Classes/Product/ProductDetails.dart';

Future<List<ProductDetails>> fetchProductDetailsById(int id) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/webProductDetails.php?status=byProductNo&id=$id'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<ProductDetails> productDetailsByID = jsonData.map((json) => ProductDetails.fromJson(json)).toList();
      return productDetailsByID;
    } else {
      throw Exception('Failed to load productDetailsByID');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}
