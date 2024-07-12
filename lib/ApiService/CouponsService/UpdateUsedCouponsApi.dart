import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../ApiEndPoint.dart';

Future<bool> updateCouponUsed(int userNo, String code) async {
  final response = await http.post(
    Uri.parse('${ApiEndpoints.localBaseUrl}/webGetCoupons.php?status=update_used'),
    body: {
      'UserNo': userNo.toString(),
      'Code': code.toString(),
      'Used': '1',
    },
  );

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);
    if (responseBody['error'] == null) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}
