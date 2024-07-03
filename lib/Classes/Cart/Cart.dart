class Cart {
  int userNo;
  int productNo;
  int productCartQty;
  String productCartPrice;

  Cart({
    required this.userNo,
    required this.productNo,
    required this.productCartQty,
    required this.productCartPrice,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      userNo: json['UserNo'] ?? 0,
      productNo: json['ProductNo'] ?? 0,
      productCartQty: json['ProductCartQty'] ?? 0,
      productCartPrice: json['ProductCartPrice'] ?? "",
    );
  }

}
