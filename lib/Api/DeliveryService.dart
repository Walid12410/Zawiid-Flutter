import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/core/config.dart';
import 'package:zawiid/model/Delivery/Delivery.dart';

class DeliveryService {
  
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


Future<List<DeliveryOption>> fetchOneDeliveryOptions(int id) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/webDeliveryOptions.php?status=one&ShippingOptionID=$id'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<DeliveryOption> oneDeliveryOptions = jsonData.map((json) => DeliveryOption.fromJson(json)).toList();
      return oneDeliveryOptions;
    } else {
      throw Exception('Failed to load one Delivery Options');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}

}