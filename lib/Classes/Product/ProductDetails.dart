class ProductDetails {
  final int productDetailsNo;
  final String productDetailsDesc;
  final int productNo;

  ProductDetails({
    required this.productDetailsNo,
    required this.productDetailsDesc,
    required this.productNo,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      productDetailsNo: json['ProductDetailsNo'] ?? 0,
      productDetailsDesc: json['ProductDetailsDesc'] ?? "",
      productNo: json['ProductNo'] ?? 0,
    );
  }
}