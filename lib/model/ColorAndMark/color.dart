class ColorProduct {
  final int colorNo;
  final String colorName;

  ColorProduct({
    required this.colorNo,
    required this.colorName,
  });

  factory ColorProduct.fromJson(Map<String, dynamic> json) {
    return ColorProduct(
      colorNo: json['ColorNo'] ?? 0,
      colorName: json['ColorName'] ?? "",
    );
  }

}