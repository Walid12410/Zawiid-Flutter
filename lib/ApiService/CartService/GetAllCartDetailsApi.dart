import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';

import '../../Classes/Cart/CartDetails.dart';

Future<List<CartDetails>> fetchAllCartDetailsByUser(int id) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/mobileCartDetailsVW.php?UserNo=$id'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<CartDetails> cartData = jsonData.map((json) => CartDetails.fromJson(json)).toList();
      return cartData;
    } else {
      throw Exception('Failed to load cart Data');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}
