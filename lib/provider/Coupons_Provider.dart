import 'package:flutter/cupertino.dart';
import 'package:zawiid/ApiService/CouponsService/CouponById.dart';
import 'package:zawiid/ApiService/CouponsService/CouponsByMarkId.dart';
import 'package:zawiid/ApiService/CouponsService/CouponsWithMarkApi.dart';
import 'package:zawiid/Classes/Coupons/Coupon.dart';
import 'package:zawiid/Classes/Coupons/CouponsMark.dart';

class CouponsProvider with ChangeNotifier {


  List<CouponMark> _couponsOfMark = [];
  List<CouponMark> get couponsOfMark => _couponsOfMark;
  getAllCouponsMark() async {
    final res = await fetchAllCouponsWithMark();
    _couponsOfMark = res;
    notifyListeners();
  }


  List<Coupon> _oneCoupon = [];
  List<Coupon> get oneCoupon => _oneCoupon;
  getOneCoupon(int id) async {
    final res = await fetchCouponsById(id);
    _oneCoupon = res;
    notifyListeners();
  }


  List<Coupon> _couponsMark = [];
  List<Coupon> get couponsMark => _couponsMark;
  getCouponsByMarkId(int id) async {
    final res = await fetchCouponsByMarkId(id);
    _couponsMark = res;
    notifyListeners();
  }



}