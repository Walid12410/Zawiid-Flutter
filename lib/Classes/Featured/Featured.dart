import '../Product/Products.dart';

class Featured {
  int featuredProductID;
  DateTime startDate;
  DateTime endDate;
  List<Product>? products;

  Featured({
    required this.featuredProductID,
    required this.startDate,
    required this.endDate,
    this.products
  });

  factory Featured.fromJson(Map<String, dynamic> json) {
    DateTime startDate = DateTime.parse(json['StartDate']['date']);
    DateTime endDate = DateTime.parse(json['EndDate']['date']);
    List<Product> products = (json['Products'] as List)
        .map((productJson) => Product.fromJson(productJson))
        .toList();

    return Featured(
      featuredProductID: json['FeaturedProductID'],
      startDate: startDate,
      endDate: endDate,
      products: products,
    );
  }
}


