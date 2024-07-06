import 'package:flutter/cupertino.dart';
import 'package:zawiid/ApiService/CouponsService/CouponById.dart';
import 'package:zawiid/ApiService/CouponsService/CouponsWithMarkApi.dart';
import 'package:zawiid/ApiService/CouponsService/GetCouponsApi.dart';
import 'package:zawiid/ApiService/CouponsService/GetCouponsByIDApi.dart';
import 'package:zawiid/Classes/Coupons/Coupon.dart';
import 'package:zawiid/Classes/Coupons/CouponsMark.dart';
import 'package:zawiid/Classes/Coupons/GetCoupons.dart';

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

  List<GetCoupon> _couponsDetailsByCouponNo = [];
  List<GetCoupon> get couponsDetailsByCouponNo => _couponsDetailsByCouponNo;
  getCouponsDetailsByCouponNo(int id) async {
    final res = await fetchGetCouponsByCouponId(id);
    _couponsDetailsByCouponNo = res;
    notifyListeners();
  }

  List<GetCoupon> _getCouponsByID = [];
  List<GetCoupon> get getCouponsByID => _getCouponsByID;
  getCouponsById(int id) async {
    final res = await fetchGetCouponsById(id);
    _getCouponsByID = res;
    notifyListeners();
  }


}