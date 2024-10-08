import 'package:zawiid/model/Product/ProductCategory.dart';

class BidProduct {
  BidProduct({
    required this.bidNo,
    required this.bidStartDate,
    required this.bidEndDate,
    required this.startPrice,
    required this.bidAmt,
    required this.soldAtPrice,
    required this.productNo,
    required this.soldToUserNo,
    required this.show,
    required this.products,
  });

  final int bidNo;
  final DateTime bidStartDate;
  final DateTime bidEndDate;
  final String startPrice;
  final String bidAmt;
  final String soldAtPrice;
  final int productNo;
  final int soldToUserNo;
  final int show;
  final List<ProductCategory> products; // Changed to List<ProductCategory>

  factory BidProduct.fromJson(Map<String, dynamic> json) {
    DateTime startDate = DateTime.parse(json['BidStartDate']['date']);
    DateTime endDate = DateTime.parse(json['BidEndDate']['date']);

    return BidProduct(
      bidNo: json["BidNo"] ?? 0,
      bidStartDate: startDate,
      bidEndDate: endDate,
      startPrice: json["StartPrice"] ?? '0.0',
      bidAmt: json["BidAmt"] ?? '0.0',
      soldAtPrice: json["SoldAtPrice"] ?? '0.0',
      productNo: json["ProductNo"] ?? 0,
      soldToUserNo: json["SoldToUserNo"] ?? 0,
      show: json["Show"] ?? 0,
      products: json["Products"] == null
          ? []
          : List<ProductCategory>.from(
          json["Products"].map((x) => ProductCategory.fromJson(x))), // Changed Product.fromJson to ProductCategory.fromJson
    );
  }
}
