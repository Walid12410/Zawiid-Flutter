import 'package:zawiid/model/Product/Products.dart';

class Offer {
  int offerNo;
  DateTime startDate;
  DateTime endDate;
  String productPrice;
  List<Product> products;

  Offer({
    required this.offerNo,
    required this.startDate,
    required this.endDate,
    required this.productPrice,
    required this.products,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      offerNo: json['OfferNo'] ?? 0,
      startDate: DateTime.parse(json['StartDate']['date']),
      endDate: DateTime.parse(json['EndDate']['date']),
      productPrice: json['ProductPrice'] ?? "",
      products: List<Product>.from(json['Products'].map((product) => Product.fromJson(product))),
    );
  }
}