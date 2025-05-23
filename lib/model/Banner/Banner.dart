class BannerModel {
  final int bannerId;
  final String bannerPosition;
  final String imageUrl;
  final int isActive;
  final DateTime createdAt;

  BannerModel({
    required this.bannerId,
    required this.bannerPosition,
    required this.imageUrl,
    required this.isActive,
    required this.createdAt,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      bannerId: json['BannerId'] ?? 0,
      bannerPosition: json['BannerPosition'] ?? "",
      imageUrl: json['ImageUrl'] ?? "",
      isActive: json['IsActive'] ?? 0,
      createdAt: json['CreatedAt'] != null && json['CreatedAt']['date'] != null
          ? DateTime.parse(json['CreatedAt']['date'])
          : DateTime.now(),  // fallback to now if null
    );
  }

  BannerModel.empty()
      : bannerId = 0,
        bannerPosition = '',
        imageUrl = '',
        isActive = 0,
        createdAt = DateTime.now();

}
