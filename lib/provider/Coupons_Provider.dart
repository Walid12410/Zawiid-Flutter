import 'package:flutter/cupertino.dart';
import 'package:zawiid/Api/CouponsService.dart';
import 'package:zawiid/model/ColorAndMark/markCoupons.dart';
import 'package:zawiid/model/Coupons/Coupon.dart';
import 'package:zawiid/model/Coupons/GetCoupons.dart';
import 'package:zawiid/model/Coupons/TotalGetCoupons.dart';

class CouponsProvider with ChangeNotifier {
  CouponsService couponService = CouponsService();


  List<Coupon> _oneCoupon = [];
  List<Coupon> get oneCoupon => _oneCoupon;
  getOneCoupon(int id) async {
    final res = await couponService.fetchCouponsById(id);
    _oneCoupon = res;
    notifyListeners();
  }

  // user coupons
  List<GetCoupon> _userCoupons = [];
  List<GetCoupon> get userCoupons => _userCoupons;
  getUserCoupons(int id) async {
    final res = await couponService.fetchUserCoupons(id);
    _userCoupons = res;
    notifyListeners();
  }

  // get total get promo
  List<TotalGetCoupons> _totalGetCoupon = [];
  List<TotalGetCoupons> get totalGetCoupon => _totalGetCoupon;
  getTotalGetCoupons() async {
    final res = await couponService.fetchTotalGetCoupons();
    _totalGetCoupon = res;
    notifyListeners();
  }

  // get all coupons by mark id
  List<Coupon> _coupons = [];
  List<Coupon> get coupons => _coupons;
  getCouponsByMarkId(int id) async {
    final res = await couponService.fetchCouponsByMarkId(id);
    _coupons = res;
    notifyListeners();
  }

  // list all mark for coupons
  List<MarkCoupon> _markCoupons = [];
  List<MarkCoupon> get markCoupons => _markCoupons;
  getAllMarkCoupons() async {
    final res = await couponService.fetchAllCouponsMark();
    _markCoupons = res;
    notifyListeners();
  }

}
