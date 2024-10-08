import 'package:zawiid/model/Categories/SubCategory.dart';

class Categories {
  final int categoryNo;
  final String categoryName;
  final List<SubCategories>? subcategories;

  Categories({
    required this.categoryNo,
    required this.categoryName,
    this.subcategories,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    List<SubCategories>? subcategoriesList;
    if (json['Subcategories'] != null) {
      subcategoriesList = <SubCategories>[];
      json['Subcategories'].forEach((v) {
        subcategoriesList!.add(SubCategories.fromJson(v));
      });
    }
    return Categories(
      categoryNo: json["CategoryNo"] ?? 0,
      categoryName: json["CategoryName"] ?? '',
      subcategories: subcategoriesList,
    );
  }
}
