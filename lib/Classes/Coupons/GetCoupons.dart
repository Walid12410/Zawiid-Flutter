class GetCoupon {
  final int getCouponNo;
  final int? userNo; // Nullable
  final int couponNo;
  final DateTime? getDate; // Nullable
  final DateTime expiryDate;
  final String code;
  final String savings;
  final String minOrderValue;
  final String validFor;

  GetCoupon({
    required this.getCouponNo,
    required this.userNo,
    required this.couponNo,
    required this.getDate,
    required this.expiryDate,
    required this.code,
    required this.savings,
    required this.minOrderValue,
    required this.validFor,
  });

  factory GetCoupon.fromJson(Map<String, dynamic> json) {
    DateTime? getDate = json['GetDate'] != null ? DateTime.parse(json['GetDate']['date']) : null;
    DateTime expiryDate = DateTime.parse(json['ExpiryDate']['date']);

    return GetCoupon(
      getCouponNo: json['GetCouponNo'] ?? 0,
      userNo: json['UserNo'],
      couponNo: json['CouponNo'] ?? 0,
      getDate: getDate,
      expiryDate: expiryDate,
      code: json['Code'] ?? "",
      savings: json['Savings'] ?? "",
      minOrderValue: json['MinOrderValue'] ?? "",
      validFor: json['ValidFor'] ?? "",
    );
  }
}