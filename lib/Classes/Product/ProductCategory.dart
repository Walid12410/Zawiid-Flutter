import 'package:zawiid/Classes/ColorAndMark/color.dart';
import 'package:zawiid/Classes/ColorAndMark/mark.dart';

class ProductCategory {
  final int productNo;
  final String productName;
  final String productDesc;
  final String price;
  final int subCategoryNo;
  final Mark? mark;
  final String? size;
  final ColorProduct? color;
  final String discountedPrice;
  final int isOpenBox;
  final int? modelNo;
  final String productImage;

  ProductCategory({
    required this.productNo,
    required this.productName,
    required this.productDesc,
    required this.price,
    required this.subCategoryNo,
    this.mark,
    this.size,
    this.color,
    required this.discountedPrice,
    required this.isOpenBox,
    this.modelNo,
    required this.productImage,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      productNo: json['ProductNo'] ?? 0,
      productName: json['ProductName'] ?? '',
      productDesc: json['ProductDesc'] ?? '',
      price: json['Price'] ?? '0.0',
      subCategoryNo: json['SubCategoryNo'] ?? 0,
      mark: json['Mark'] != null ? Mark.fromJson(json['Mark']) : Mark(markNo: 0, markName: "", markDesc: "", markImage: ""), // Handle null case
      size: json['Size'] ?? "",
      color:  json['Color'] != null ? ColorProduct.fromJson(json['Color']) : ColorProduct(colorNo: 0, colorName: "") ,
      discountedPrice: json['DiscountedPrice'] ?? '0.0',
      isOpenBox: json['IsOpenBox'] ?? 0,
      modelNo: json['ModelNo'] ?? 0,
      productImage: json['ProductImage'] ?? '',
    );
  }
}
