import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Classes/Bid/BIdZawid.dart';

Future<List<BidZawid>> fetchLatestBid(int bidNo) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/mobileBidZawid.php?status=highestPrice&BidNo=$bidNo'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<BidZawid> latestBid = jsonData.map((json) => BidZawid.fromJson(json)).toList();
      return latestBid;
    } else {
      throw Exception('Failed to load latest Bid');
    }
  } catch (e) {
    throw Exception('Server Error $e');
  }
}
