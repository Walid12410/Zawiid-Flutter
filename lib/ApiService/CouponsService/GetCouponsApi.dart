import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Classes/Coupons/GetCoupons.dart';

Future<List<GetCoupon>> fetchGetCouponsByCouponId(int id) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/webGetCoupons.php?status=byCouponsId&CouponNo=$id'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<GetCoupon> getCoupons = jsonData.map((json) => GetCoupon.fromJson(json)).toList();
      return getCoupons;

    } else {
      throw Exception('Failed to load coupons Of get Coupons');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}
