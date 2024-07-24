import 'OfferResponse.dart';

class OffersData {
  final bool found;
  final List<OfferResponse> offers;

  OffersData({
    required this.found,
    required this.offers,
  });

  factory OffersData.fromJson(Map<String, dynamic> json) {
    return OffersData(
      found: json['found'] ?? false,
      offers: json['data'] != null && json['data']['offers'] != null
          ? List<OfferResponse>.from(json['data']['offers'].map((offer) => OfferResponse.fromJson(offer)))
          : [],
    );
  }
}
