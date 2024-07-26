import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Classes/Bid/BIdZawid.dart';

Future<List<BidZawid>> fetchLatestUserBid(int userNo, int bidNo) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/mobileBidZawid.php?status=LastBidUser&UserNo=$userNo&BidNo=$bidNo'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<BidZawid> userLatestBid = jsonData.map((json) => BidZawid.fromJson(json)).toList();
      return userLatestBid;
    } else {
      throw Exception('Failed to load user LatestBid');
    }
  } catch (e) {
    throw Exception('Server Error $e');
  }
}
