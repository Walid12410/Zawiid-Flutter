class ProductSubCategory {
  final int subCarNo;
  final String subCatName;
  final int productNo;
  final String productName;
  final String productDesc;
  final int markNo;
  final int colorNo;
  final String discountPrice;
  final String price;
  final String productImag;
  final String markName;
  final String colorName;


  ProductSubCategory({
    required this.subCarNo,
    required this.subCatName,
    required this.productNo,
    required this.productName,
    required this.productDesc,
    required this.markNo,
    required this.colorNo,
    required this.discountPrice,
    required this.price,
    required this.productImag,
    required this.markName,
    required this.colorName
  });


  factory ProductSubCategory.fromJson(Map<String , dynamic> json){
    return ProductSubCategory(
      subCarNo: json['SubCarNo'] ?? 0, 
      subCatName: json['SubCatName'] ?? "",
      productNo: json['ProductNo'] ?? 0,
      productName: json['ProductName'] ?? "",
      productDesc: json['ProductDesc'] ?? "",
      markNo: json['MarkNo'] ?? 0,
      colorNo: json['ColorNo'] ?? 0,
      discountPrice: json['DiscountedPrice'] ?? "0.0",
      price: json['Price'] ?? "",
      productImag: json['ProductImage'] ?? "",
      markName: json['MarkName'] ?? "", 
      colorName: json['ColorName'] ?? ""
    );
  }
}