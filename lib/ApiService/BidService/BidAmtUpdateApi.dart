import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';

Future<void> updateBidAmt(int bidNo, String amountToAdd) async {
  final url = Uri.parse("${ApiEndpoints.localBaseUrl}/webUpdateBid.php");
  final response = await http.post(
    url,
    body: {
      'status': 'updateBidAmt',
      'BidNo': bidNo.toString(),
      'amountToAdd': amountToAdd.toString(),
    },
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    print('Response: ${jsonResponse['message']}');
  } else {
    throw Exception('Failed to update bid amount');
  }
}
