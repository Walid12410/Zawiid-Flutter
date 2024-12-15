class FeaturedProduct {
  final int featuredProductID;
  final DateTime startDate;
  final DateTime endDate;
  final int productNo;
  final String productName;
  final String productDesc;
  final String price;
  final int colorNo;
  final String discountedPrice;
  final String productImage;
  final int markNo;

  FeaturedProduct({
    required this.featuredProductID,
    required this.startDate,
    required this.endDate,
    required this.productNo,
    required this.productName,
    required this.productDesc,
    required this.price,
    required this.colorNo,
    required this.discountedPrice,
    required this.productImage,
    required this.markNo,
  });

  // Factory method to create an object from JSON
  factory FeaturedProduct.fromJson(Map<String, dynamic> json) {
    return FeaturedProduct(
      featuredProductID: json['FeaturedProductID'] ?? 0,
      startDate: DateTime.parse(json['StartDate']['date'] ?? DateTime.now().toIso8601String()),
      endDate: DateTime.parse(json['EndDate']['date'] ?? DateTime.now().toIso8601String()),
      productNo: json['ProductNo'] ?? 0,
      productName: json['ProductName'] ?? "",
      productDesc: json['ProductDesc'] ?? "",
      price: json['Price'] ?? "0.0",
      colorNo: json['ColorNo'] ?? 0,
      discountedPrice: json['DiscountedPrice'] ?? "0.0",
      productImage: json['ProductImage'] ?? "",
      markNo: json['MarkNo'] ?? 0,
    );
  }
}
