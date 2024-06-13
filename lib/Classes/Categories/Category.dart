import 'package:zawiid/Classes/Categories/SubCategory.dart';

class Categories {
  int categoryNo;
  String categoryName;
  String? photo;
  List<SubCategories>? subcategories;

  Categories({
    required this.categoryNo,
    required this.categoryName,
    this.photo,
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
      photo: json["Photo"],
      subcategories: subcategoriesList,
    );
  }
}
