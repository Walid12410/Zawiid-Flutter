class BidProduct {
  final int bidNo;
  final DateTime bidStartDate;
  final DateTime bidEndDate;
  final String startPrice;
  final String bidAmt;
  final String? soldAtPrice;
  final int productNo;
  final int? soldToUserNo;
  final int show;
  final String productName;
  final String productDesc;
  final String price;
  final int subCategoryNo;
  final int markNo;
  final String size;
  final int colorNo;
  final String discountedPrice;
  final int isOpenBox;
  final String productImage;
  final String markName;
  final String colorName;

  BidProduct({
    required this.bidNo,
    required this.bidStartDate,
    required this.bidEndDate,
    required this.startPrice,
    required this.bidAmt,
    this.soldAtPrice,
    required this.productNo,
    this.soldToUserNo,
    required this.show,
    required this.productName,
    required this.productDesc,
    required this.price,
    required this.subCategoryNo,
    required this.markNo,
    required this.size,
    required this.colorNo,
    required this.discountedPrice,
    required this.isOpenBox,
    required this.productImage,
    required this.markName,
    required this.colorName,
  });

  // Factory method to create an object from JSON
  factory BidProduct.fromJson(Map<String, dynamic> json) {
    DateTime startDate = DateTime.parse(json['BidStartDate']['date']);
    DateTime endDate = DateTime.parse(json['BidEndDate']['date']);

    return BidProduct(
      bidNo: json['BidNo'] ?? 0,
      bidStartDate: startDate,
      bidEndDate: endDate,
      startPrice: json["StartPrice"] ?? '0.0',
      bidAmt: json["BidAmt"] ?? '0.0',
      soldAtPrice: json["SoldAtPrice"] ?? '0.0',
      productNo: json['ProductNo'] ?? 0,
      soldToUserNo: json['SoldToUserNo'] ?? 0,
      show: json['Show'] ?? 0,
      productName: json['ProductName'] ?? "",
      productDesc: json['ProductDesc'] ?? "",
      price: json['Price'] ?? "0.0",
      subCategoryNo: json['SubCategoryNo'] ?? 0,
      markNo: json['MarkNo'] ?? 0,
      size: json['size'] ?? "",
      colorNo: json['ColorNo'] ?? 0,
      discountedPrice: json['DiscountedPrice'] ?? "0.0",
      isOpenBox: json['IsOpenBox'] ?? 0,
      productImage: json['ProductImage'] ?? "",
      markName: json['MarkName'] ?? "",
      colorName: json['ColorName'] ?? "",
    );
  }
}
