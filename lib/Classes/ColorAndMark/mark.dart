class Mark {
  final int markNo;
  final String markName;
  final String? markDesc;
  final String? markImage;

  Mark({
    required this.markNo,
    required this.markName,
    this.markDesc,
    this.markImage,
  });

  factory Mark.fromJson(Map<String, dynamic> json) {
    return Mark(
      markNo: json['MarkNo'] ?? 0,
      markName: json['MarkName'] ?? "",
      markDesc: json['MarkDesc'] ?? "",
      markImage: json['MarkImage'] ?? "",
    );
  }

}