import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';

Future<void> updateCart(int userNo, int productNo, int quantity, double price) async {
  final url = Uri.parse('${ApiEndpoints.localBaseUrl}/webCart.php');
  try {
    final response = await http.post(
      url,
      body: {
        'status': 'update',
        'UserNo': userNo.toString(),
        'ProductNo': productNo.toString(),
        'ProductCartQty': quantity.toString(),
        'ProductCartPrice': price.toString(),
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['error'] != null) {
        throw Exception('Failed to update cart: ${data['error']}');
      }
    } else {
      throw Exception('Failed to update cart: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception(e);
  }
}

