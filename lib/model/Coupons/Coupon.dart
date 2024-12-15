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
  final String markName;
  final String markDesc;
  final String markImage; 

  Coupon({
    required this.couponNo,
    required this.markNo,
    required this.issueDate,
    required this.expiryDate,
    required this.code,
    required this.savings,
    required this.minOrderValue,
    required this.couponDesc,
    required this.validFor,
    required this.markName,
    required this.markDesc,
    required this.markImage
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
      validFor: json['ValidFor'] ?? "",
      markName: json['MarkName'] ?? "" ,
      markDesc: json['MarkDesc'] ?? "",
      markImage: json['MarkImage'] ?? ""
    );
  }
}
