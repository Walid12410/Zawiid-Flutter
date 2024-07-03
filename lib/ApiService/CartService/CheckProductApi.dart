import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Classes/Cart/Cart.dart';

Future<List<Cart>> fetchProductCartFound(int userID, int productID) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/webCart.php?status=one&UserNo=$userID&ProductNo=$productID'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Cart> cartData = jsonData.map((json) => Cart.fromJson(json)).toList();
      return cartData;
    } else {
      throw Exception('Failed to load cart Data');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}
