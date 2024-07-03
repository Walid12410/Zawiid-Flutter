import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';


Future<void> addBidZawid(int bidNo, int userNo, double zawidAmt) async {
   String url = '${ApiEndpoints.localBaseUrl}/webBidzawid.php';

  try {
    final response = await http.post(
      Uri.parse(url),
      body: {
        'status': 'new',
        'BidNo': bidNo.toString(),
        'UserNo': userNo.toString(),
        'ZawidAmt': zawidAmt.toString(),
        'ZawidDate': DateTime.now(),
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print('Response: $jsonResponse');
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception: $e');
  }
}
