import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/core/config.dart';
import 'package:zawiid/model/Order/OrderDetails.dart';




class OrderService {
  
Future<List<OrderDetails>> fetchOrderByUser(int userId) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/MobileApi/mobileOrderUserVW.php?userNo=$userId'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<OrderDetails> orderDetails = jsonData.map((json) => OrderDetails.fromJson(json)).toList();
      return orderDetails;
    } else {
      throw Exception('Failed to load order Details');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}

}