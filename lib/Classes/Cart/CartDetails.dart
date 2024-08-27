class CartDetails {
  final int userNo;
  final int productNo;
  final int productCartQty;
  final String productCartPrice;
  final int markNo;
  final String markName;
  final String productName;
  final String productDesc;
  final String productImage;

  CartDetails({
    required this.userNo,
    required this.productNo,
    required this.productCartQty,
    required this.productCartPrice,
    required this.markNo,
    required this.markName,
    required this.productName,
    required this.productDesc,
    required this.productImage
  });

  factory CartDetails.fromJson(Map<String, dynamic> json) {
    return CartDetails(
      userNo: json['UserNo'] ?? 0,
      productNo: json['ProductNo'] ?? 0,
      productCartQty: json['ProductCartQty'] ?? 0,
      productCartPrice: json['ProductCartPrice'] ?? "",
      markNo: json['MarkNo'] ?? 0,
      markName: json['MarkName'] ?? "",
      productName: json['ProductName'] ?? "",
      productDesc: json['ProductDesc'] ?? "",
      productImage: json['ProductImage'] ?? ""
    );
  }
}

