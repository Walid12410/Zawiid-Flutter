import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';

Future<void> deleteCartItem({
  required int userNo,
  required int productNo,
}) async {
  final url = Uri.parse('${ApiEndpoints.localBaseUrl}/webCart.php');

  final response = await http.post(
    url,
    body: {
      'status': 'delete',
      'UserNo': userNo.toString(),
      'ProductNo': productNo.toString(),
    },
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    if (responseData['error'] != null) {
      throw Exception(responseData['error']);
    } else {
      print('success');
    }
  } else {
    throw Exception('Failed to delete cart item');
  }
}
