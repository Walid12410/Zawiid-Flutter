import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';

Future<void> deleteAllCartItemsByUserNo(int userNo) async {
  final url = Uri.parse('${ApiEndpoints.localBaseUrl}/webCart.php');

  final response = await http.post(
    url,
    body: {
      'status': 'deleteByUserNo',
      'UserNo': userNo.toString(),
    },
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    if (responseData['error'] != null) {
      throw Exception(responseData['error']);
    } else {
      print('delete success');
    }
  } else {
    throw Exception('Failed to delete cart items');
  }
}
