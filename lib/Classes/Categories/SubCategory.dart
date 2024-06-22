class SubCategories {
  final int subCarNo;
  final String subCatName;
  final int categoryNo;
  final String? photo;

  SubCategories({
    required this.subCarNo,
    required this.subCatName,
    required this.categoryNo,
    this.photo,
  });

  factory SubCategories.fromJson(Map<String, dynamic> json) =>
      SubCategories(
        subCarNo: json["SubCarNo"] ?? 0,
        subCatName: json["SubCatName"] ?? '',
        categoryNo: json["CategoryNo"] ?? 0,
        photo: json["photo"],
      );
}