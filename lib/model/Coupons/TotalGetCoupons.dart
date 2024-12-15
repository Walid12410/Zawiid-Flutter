class TotalGetCoupons {
  final int couponNo;
  final int totalGetCoupons;

  TotalGetCoupons({
    required this.couponNo,
    required this.totalGetCoupons
  });

  factory TotalGetCoupons.fromJson(Map<String , dynamic> json) {
    return TotalGetCoupons(
      couponNo: json['CouponNo'] ?? 0,
      totalGetCoupons: json['TotalGetCoupons'] ?? 0
    );
  }

}