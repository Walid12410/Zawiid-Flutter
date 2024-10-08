import 'package:flutter/cupertino.dart';
import 'package:zawiid/Api/OfferService.dart';
import 'package:zawiid/model/CheckOffer/OfferResponse.dart';
import 'package:zawiid/model/offer/offer.dart';

class OfferProvider with ChangeNotifier {
  OfferService service = OfferService();

  List<Offer> _allOffer = [];
  List<Offer> get allOffer => _allOffer;
  getAllOffer() async {
    final res = await service.fetchAllOffer();
    _allOffer = res;
    notifyListeners();
  }

  List<OfferResponse> _offerCheck = [];

  List<OfferResponse> get offerCheck {
    DateTime now = DateTime.now();
    return _offerCheck.where((offer) {
      return now.isAfter(offer.startDate) && now.isBefore(offer.endDate);
    }).toList();
  }

  getOfferCheck(int id) async {
    final res = await service.fetchOfferCheck(id);
    _offerCheck = res.offers;
    notifyListeners();
  }
}
