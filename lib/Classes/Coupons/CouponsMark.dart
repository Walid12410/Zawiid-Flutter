import 'package:zawiid/Classes/ColorAndMark/mark.dart';

class CouponMark {
  final int couponNo;
  final int markNo;
  final DateTime issueDate;
  final DateTime expiryDate;
  final String code;
  final String savings;
  final String minOrderValue;
  final Mark mark;

  CouponMark({
    required this.couponNo,
    required this.markNo,
    required this.issueDate,
    required this.expiryDate,
    required this.code,
    required this.savings,
    required this.minOrderValue,
    required this.mark,
  });

  factory CouponMark.fromJson(Map<String, dynamic> json) {
    DateTime issueDate = DateTime.parse(json['IssueDate']['date']);
    DateTime expiryDate = DateTime.parse(json['ExpiryDate']['date']);
    Mark mark = Mark.fromJson(json['Mark']);

    return CouponMark(
      couponNo: json['CouponNo'] ?? 0,
      markNo: json['MarkNo'] ?? 0,
      issueDate: issueDate,
      expiryDate: expiryDate,
      code: json['Code'] ?? "",
      savings: json['Savings'] ?? "",
      minOrderValue: json['MinOrderValue'] ?? "",
      mark: mark,
    );
  }
}
