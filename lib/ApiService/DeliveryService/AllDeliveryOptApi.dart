import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Classes/Delivery/Delivery.dart';

Future<List<DeliveryOption>> fetchAllDeliveryOptions() async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/webDeliveryOptions.php?status=select'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<DeliveryOption> deliveryData = jsonData.map((json) => DeliveryOption.fromJson(json)).toList();
      return deliveryData;
    } else {
      throw Exception('Failed to load delivery Data');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}
