import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Classes/Bid/bidProduct.dart';

Future<List<BidProduct>> fetchAllBid() async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/MobileApi/mobileBid.php'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<BidProduct> bidData = jsonData.map((json) => BidProduct.fromJson(json)).toList();
      return bidData;
    } else {
      throw Exception('Failed to load bidData');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}
