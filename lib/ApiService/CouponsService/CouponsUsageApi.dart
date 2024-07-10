import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';



Future<int> fetchCouponUsage(int couponNo) async {
  final response = await http.get(
    Uri.parse('${ApiEndpoints.localBaseUrl}/webGetCoupons.php?status=countGetCouponUsed&CouponNo=$couponNo'),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data is List && data.isNotEmpty) {
      return data[0]['TotalGetCoupons'];
    } else {
      throw Exception('Invalid response format');
    }
  } else {
    throw Exception('Failed to load coupon usage');
  }
}
