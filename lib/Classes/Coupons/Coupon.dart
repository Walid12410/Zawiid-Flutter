class Coupon {
  final int couponNo;
  final int markNo;
  final DateTime issueDate;
  final DateTime expiryDate;
  final String code;
  final String savings;
  final String minOrderValue;
  final String couponDesc;
  final String validFor;


  Coupon({
    required this.couponNo,
    required this.markNo,
    required this.issueDate,
    required this.expiryDate,
    required this.code,
    required this.savings,
    required this.minOrderValue,
    required this.couponDesc,
    required this.validFor
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    DateTime issueDate = DateTime.parse(json['IssueDate']['date']);
    DateTime expiryDate = DateTime.parse(json['ExpiryDate']['date']);

    return Coupon(
      couponNo: json['CouponNo'] ?? 0,
      markNo: json['MarkNo'] ?? 0,
      issueDate: issueDate,
      expiryDate: expiryDate,
      code: json['Code'] ?? "",
      savings: json['Savings'] ?? "",
      minOrderValue: json['MinOrderValue'] ?? "",
      couponDesc: json['CouponDesc'] ?? "",
      validFor: json['ValidFor'] ?? ""
    );
  }
}
