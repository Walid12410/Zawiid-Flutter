import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Classes/offer/offer.dart';

Future<List<Offer>> fetchAllOffer() async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/mobileOffer.php'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Offer> allOffer = jsonData.map((json) => Offer.fromJson(json)).toList();
      return allOffer;
    } else {
      throw Exception('Failed to load all Offer');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}
