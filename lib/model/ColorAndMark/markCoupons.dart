class MarkCoupon {
  final int markNo;
  final String markName;
  final String markDesc;
  final String markImage;
  final int couponCount;

  // Constructor
  MarkCoupon({
    required this.markNo,
    required this.markName,
    required this.markDesc,
    required this.markImage,
    required this.couponCount,
  });

  // Factory method to create an object from JSON
  factory MarkCoupon.fromJson(Map<String, dynamic> json) {
    return MarkCoupon(
      markNo: json['MarkNo'] ?? 0,
      markName: json['MarkName'] ?? "",
      markDesc: json['MarkDesc'] ?? "",
      markImage: json['MarkImage'] ?? "",
      couponCount: json['CouponCount'] ?? "",
    );
  }

}
