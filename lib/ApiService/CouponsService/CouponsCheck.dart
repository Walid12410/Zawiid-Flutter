import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:zawiid/ApiEndPoint.dart';

Future<String> checkCouponStatus(int userNo, int couponNo) async {
  final response = await http.get(Uri.parse(
      '${ApiEndpoints.localBaseUrl}/webGetCoupons.php?status=byUserId&UserNo=$userNo&CouponNo=$couponNo'));

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['message'] == 'Coupon found') {
      if (jsonResponse['used'] == 1) {
        return 'Used';
      } else {
        return 'Show Coupon';
      }
    } else {
      return 'Get Coupon';}
  } else {
    throw Exception('Failed to check coupon status');
  }
}