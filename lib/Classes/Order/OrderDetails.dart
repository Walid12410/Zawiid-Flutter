class OrderDetails {
  final int userNo;
  final int orderNo;
  final int delivered;
  final int productNo;
  final String productPrice;
  final String productDiscountAmt;
  final int productQty;
  final String productName;
  final String productDesc;
  final String productImage;

  OrderDetails({
    required this.userNo,
    required this.orderNo,
    required this.delivered,
    required this.productNo,
    required this.productPrice,
    required this.productDiscountAmt,
    required this.productQty,
    required this.productName,
    required this.productDesc,
    required this.productImage,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      userNo: json['UserNo'] ?? 0,
      orderNo: json['OrderNo'] ?? 0,
      delivered: json['Delivered'] ?? 0,
      productNo: json['ProductNo'] ?? 0,
      productPrice: json['ProductPrice'] ?? "" ,
      productDiscountAmt: json['ProductDiscountAmt'] ?? "",
      productQty: json['ProductQty'] ?? 0,
      productName: json['ProductName'] ?? "",
      productDesc: json['ProductDesc'] ?? "",
      productImage: json['ProductImage'] ?? "",
    );
  }
}
