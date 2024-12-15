import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:zawiid/core/config.dart';
import 'package:zawiid/model/ColorAndMark/markCoupons.dart';
import 'dart:convert';
import 'package:zawiid/model/Coupons/Coupon.dart';
import 'package:zawiid/model/Coupons/GetCoupons.dart';
import 'package:zawiid/model/Coupons/TotalGetCoupons.dart';

class CouponsService {
// fetch all coupons by markId
  Future<List<Coupon>> fetchCouponsByMarkId(int id) async {
    String date =
        DateFormat('yyyy-MM-dd HH:mm:ss', 'en_US').format(DateTime.now());
    try {
      final response = await http.get(Uri.parse(
          '${ApiEndpoints.localBaseUrl}/MobileApi/mobileCoupons.php?status=couponsList&currentTime=$date&markNo=$id'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Coupon> couponsMark =
            jsonData.map((json) => Coupon.fromJson(json)).toList();
        return couponsMark;
      } else {
        throw Exception('Failed to load coupons Of coupons Mark');
      }
    } catch (e) {
      throw Exception('Server Error');
    }
  }

  Future<List<MarkCoupon>> fetchAllCouponsMark() async {
    String date =
        DateFormat('yyyy-MM-dd HH:mm:ss', 'en_US').format(DateTime.now());
    try {
      final response = await http.get(Uri.parse(
          '${ApiEndpoints.localBaseUrl}/MobileApi/mobileCoupons.php?status=couponsMark&currentTime=$date'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<MarkCoupon> couponsOfMark =
            jsonData.map((json) => MarkCoupon.fromJson(json)).toList();
        return couponsOfMark;
      } else {
        throw Exception('Failed to load coupons Of coupons Mark');
      }
    } catch (e) {
      throw Exception('Server Error');
    }
  }

  // @TODO remove it
  Future<List<Coupon>> fetchCouponsById(int id) async {
    try {
      final response = await http.get(Uri.parse(
          '${ApiEndpoints.localBaseUrl}/webCoupons.php?status=one&CouponID=$id'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Coupon> oneCoupon =
            jsonData.map((json) => Coupon.fromJson(json)).toList();
        return oneCoupon;
      } else {
        throw Exception('Failed to load coupons Of one Coupon');
      }
    } catch (e) {
      throw Exception('Server Error');
    }
  }

  Future<List<GetCoupon>> fetchUserCoupons(int id) async {
    try {
      final response = await http.get(Uri.parse(
          '${ApiEndpoints.localBaseUrl}/MobileApi/mobileCoupons.php?status=userCoupons&UserNo=$id'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<GetCoupon> userCoupons =
            jsonData.map((json) => GetCoupon.fromJson(json)).toList();
        return userCoupons;
      } else {
        throw Exception('Failed to load user coupons');
      }
    } catch (e) {
      throw Exception('Server Error');
    }
  }

  Future<List<TotalGetCoupons>> fetchTotalGetCoupons() async {
    try {
      final response = await http.get(Uri.parse(
          '${ApiEndpoints.localBaseUrl}/MobileApi/mobileCoupons.php?status=totalGetCoupon'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<TotalGetCoupons> totalGetCoupon =
            jsonData.map((json) => TotalGetCoupons.fromJson(json)).toList();
        return totalGetCoupon;
      } else {
        throw Exception('Failed to load total get coupon');
      }
    } catch (e) {
      throw Exception('Server Error');
    }
  }

  Future<bool> getCoupons(
      {required int userNo,
      required String expiryDate,
      required int used,
      required int couponNo,
      required String code,
      required String savings,
      required minOrderValue,
      required validFor}) async {
    final url =
        Uri.parse('${ApiEndpoints.localBaseUrl}/webGetCoupons.php?status=new');

    String getDate =
        DateFormat('yyyy-MM-dd HH:mm:ss', 'en_US').format(DateTime.now());

    final response = await http.post(
      url,
      body: {
        'UserNo': userNo.toString(),
        'GetDate': getDate,
        'ExpiryDate': expiryDate,
        'Used': used.toString(),
        'CouponNo': couponNo.toString(),
        'Code': code.toString(),
        'Savings': savings.toString(),
        'MinOrderValue': minOrderValue.toString(),
        'ValidFor': validFor.toString()
      },
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['message'] ==
          'GetCoupons entry has been successfully added.') {
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
      Uri.parse(
          '${ApiEndpoints.localBaseUrl}/webGetCoupons.php?status=update_used'),
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
    final DateFormat dateTimeFormat =
        DateFormat('yyyy-MM-dd HH:mm:ss', 'en_US');

    final response = await http.post(
      Uri.parse(
          '${ApiEndpoints.localBaseUrl}/MobileApi/mobileCheckPromeCode.php'),
      body: {
        'UserNo': userNo.toString(),
        'PromoCode': promoCode.toString(),
        'OrderTotal': orderTotal.toString(),
        'UserCurrentDate': dateTimeFormat.toString()
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {'valid': false};
    }
  }
}
