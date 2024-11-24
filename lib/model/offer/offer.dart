class Offer {
  int offerNo;
  DateTime startDate;
  DateTime endDate;
  String productPrice;
  final int productNo;
  final int colorNo;
  final int markNo;
  final String productName;
  final String productDesc;
  final String productImage;

  Offer(
      {required this.offerNo,
      required this.startDate,
      required this.endDate,
      required this.productPrice,
      required this.productNo,
      required this.colorNo,
      required this.markNo,
      required this.productName,
      required this.productDesc,
      required this.productImage
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      offerNo: json['OfferNo'] ?? 0,
      startDate: DateTime.parse(json['StartDate']['date']),
      endDate: DateTime.parse(json['EndDate']['date']),
      productPrice: json['ProductPrice'] ?? "",
      productNo: json["ProductNo"] ?? 0,
      productName: json["ProductName"] ?? '',
      productDesc: json["ProductDesc"] ?? '',
      markNo: json["MarkNo"] ?? 0,
      colorNo: json["ColorNo"] ?? 0,
      productImage: json["ProductImage"] ?? '',
    );
  }
}
