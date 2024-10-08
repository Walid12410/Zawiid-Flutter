import 'package:flutter/cupertino.dart';
import 'package:zawiid/Api/CouponsService.dart';
import 'package:zawiid/model/Coupons/Coupon.dart';
import 'package:zawiid/model/Coupons/CouponsMark.dart';

class CouponsProvider with ChangeNotifier {
  CouponsService couponService = CouponsService();

  List<CouponMark> _couponsOfMark = [];
  List<CouponMark> get couponsOfMark => _couponsOfMark;
  getAllCouponsMark() async {
    final res = await couponService.fetchAllCouponsWithMark();
    _couponsOfMark = res;
    notifyListeners();
  }

  List<Coupon> _oneCoupon = [];
  List<Coupon> get oneCoupon => _oneCoupon;
  getOneCoupon(int id) async {
    final res = await couponService.fetchCouponsById(id);
    _oneCoupon = res;
    notifyListeners();
  }

  List<Coupon> _couponsMark = [];
  List<Coupon> get couponsMark => _couponsMark;
  getCouponsByMarkId(int id) async {
    final res = await couponService.fetchCouponsByMarkId(id);
    _couponsMark = res;
    notifyListeners();
  }
}
