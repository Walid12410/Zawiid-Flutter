class BidZawid {
  final int zawidNo;
  final int bidNo;
  final int userNo;
  final String zawidAmt;
  final DateTime zawidDate;

  BidZawid({
    required this.zawidNo,
    required this.bidNo,
    required this.userNo,
    required this.zawidAmt,
    required this.zawidDate,
  });

  factory BidZawid.fromJson(Map<String, dynamic> json) {
    DateTime bidDate = DateTime.parse(json['ZawidDate']['date']);

    return BidZawid(
      zawidNo: json['ZawidNo'] ?? 0,
      bidNo: json['BidNo'] ?? 0,
      userNo: json['UserNo'] ?? 0,
      zawidAmt: json['ZawidAmt'] ?? "0.0",
      zawidDate: bidDate,
    );
  }
}
