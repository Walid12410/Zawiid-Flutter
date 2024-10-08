class Bid {
  Bid({
    required this.bidNo,
    required this.bidStartDate,
    required this.bidEndDate,
    required this.startPrice,
    this.bidAmt,
    this.soldAtPrice,
    required this.productNo,
    this.soldToUserNo,
    required this.show,
  });

  final int bidNo;
  final DateTime bidStartDate;
  final DateTime bidEndDate;
  final String startPrice;
  final String? bidAmt;
  final String? soldAtPrice;
  final int productNo;
  final int? soldToUserNo;
  final int show;

  factory Bid.fromJson(Map<String, dynamic> json) {
    DateTime startDate = DateTime.parse(json['BidStartDate']['date']);
    DateTime endDate = DateTime.parse(json['BidEndDate']['date']);

    return Bid(
      bidNo: json["BidNo"] ?? 0,
      bidStartDate: startDate,
      bidEndDate: endDate,
      startPrice: json["StartPrice"] ?? '0.0',
      bidAmt: json["BidAmt"] ?? '0.0',
      soldAtPrice: json["SoldAtPrice"] ?? '0.0',
      productNo: json["ProductNo"] ?? 0,
      soldToUserNo: json["SoldToUserNo"] ?? 0,
      show: json["Show"] ?? 0,
    );
  }
}
