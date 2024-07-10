

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Classes/Coupons/Coupon.dart';

Future<List<Coupon>> fetchCouponsById(int id) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/webCoupons.php?status=one&CouponID=$id'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Coupon> oneCoupon = jsonData.map((json) => Coupon.fromJson(json)).toList();
      return oneCoupon;

    } else {
      throw Exception('Failed to load coupons Of one Coupon');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}
