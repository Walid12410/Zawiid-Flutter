import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Classes/Bid/Bid.dart';

Future<List<Bid>> fetchBidById(int id) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/webBid.php?status=one&BidNo=$id'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Bid> bidById = jsonData.map((json) => Bid.fromJson(json)).toList();
      return bidById;
    } else {
      throw Exception('Failed to load bidById');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}
