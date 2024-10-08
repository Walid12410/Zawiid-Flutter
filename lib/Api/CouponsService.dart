import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:zawiid/core/config.dart';
import 'dart:convert';

import 'package:zawiid/model/Coupons/Coupon.dart';
import 'package:zawiid/model/Coupons/CouponsMark.dart';


class CouponsService{

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

Future<bool> getCoupons({
  required int userNo,
  required String expiryDate,
  required int used,
  required int couponNo,
  required String code,
  required String savings,
  required minOrderValue,
  required validFor
  }) async {
  final url = Uri.parse('${ApiEndpoints.localBaseUrl}/webGetCoupons.php?status=new');

  String getDate = DateFormat('yyyy-MM-dd HH:mm:ss', 'en_US').format(DateTime.now());

  final response = await http.post(
    url,
    body: {
      'UserNo': userNo.toString(),
      'GetDate': getDate,
      'ExpiryDate': expiryDate,
      'Used': used.toString(),
      'CouponNo': couponNo.toString(),
      'Code' : code.toString(),
      'Savings' : savings.toString(),
      'MinOrderValue' : minOrderValue.toString(),
      'ValidFor' : validFor.toString()
    },
  );

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);
    if (responseBody['message'] == 'GetCoupons entry has been successfully added.') {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}

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

Future<Map<String, dynamic>> validatePromoCode(
    int userNo, String promoCode, double orderTotal) async {

  final DateFormat dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss', 'en_US');


  final response = await http.post(
    Uri.parse('${ApiEndpoints.localBaseUrl}/MobileApi/mobileCheckPromeCode.php'),
    body: {
      'UserNo': userNo.toString(),
      'PromoCode': promoCode.toString(),
      'OrderTotal': orderTotal.toString(),
      'UserCurrentDate' : dateTimeFormat.toString()
    },
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return {'valid': false};
  }
}

}