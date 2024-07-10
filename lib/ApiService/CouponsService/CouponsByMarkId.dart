import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Classes/Coupons/Coupon.dart';

Future<List<Coupon>> fetchCouponsByMarkId(int id) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/webCoupons.php?status=byMarkNo&MarkNo=$id'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Coupon> couponsMark = jsonData.map((json) => Coupon.fromJson(json)).toList();
      return couponsMark;

    } else {
      throw Exception('Failed to load coupons Of coupons Mark');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}
