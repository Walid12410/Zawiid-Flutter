import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Classes/Address/Address.dart';

Future<List<Address>> fetchAddressOfUser(int id) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/webAddress.php?status=byUserNo&id=$id'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Address> viewAddress = jsonData.map((json) => Address.fromJson(json)).toList();
      return viewAddress;
    } else {
      throw Exception('Failed to load viewAddress');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}
