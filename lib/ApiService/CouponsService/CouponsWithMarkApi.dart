import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import '../../Classes/Coupons/CouponsMark.dart';

Future<List<CouponMark>> fetchAllCouponsWithMark() async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/MobileApi/mobileCoupons.php'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<CouponMark> couponsOfMark = jsonData.map((json) => CouponMark.fromJson(json)).toList();
      return couponsOfMark;

    } else {
      throw Exception('Failed to load coupons Of coupons Mark');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}
