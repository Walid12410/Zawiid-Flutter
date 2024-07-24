class OfferResponse {
  final int offerNo;
  final DateTime startDate;
  final DateTime endDate;
  final int productNo;
  final String productPrice;

  OfferResponse({
    required this.offerNo,
    required this.startDate,
    required this.endDate,
    required this.productNo,
    required this.productPrice,
  });

  factory OfferResponse.fromJson(Map<String, dynamic> json) {
    return OfferResponse(
      offerNo: json['OfferNo'] ?? 0,
      startDate: DateTime.parse(json['StartDate']['date'] ?? '1970-01-01 00:00:00.000000'),
      endDate: DateTime.parse(json['EndDate']['date'] ?? '1970-01-01 00:00:00.000000'),
      productNo: json['ProductNo'] ?? 0,
      productPrice: (json['ProductPrice'] != null) ? json['ProductPrice'] : "0.0",
    );
  }
}

