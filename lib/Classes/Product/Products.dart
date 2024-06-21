class Product {

  final int productNo;
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


  Product({
    required this.productNo,
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
  });


  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      productNo: json["ProductNo"] ?? 0,
      productName: json["ProductName"] ?? '',
      productDesc: json["ProductDesc"] ?? '',
      price: json["Price"] ?? '',
      subCategoryNo: json["SubCategoryNo"] ?? 0,
      markNo: json["MarkNo"] ?? 0,
      size: json["size"] ?? 0,
      colorNo: json["ColorNo"] ?? 0,
      discountedPrice: json["DiscountedPrice"]?? '',
      isOpenBox: json["IsOpenBox"] ?? 0,
      productImage: json["ProductImage"] ?? '',
    );
  }

}
