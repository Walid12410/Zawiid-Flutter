import 'package:flutter/cupertino.dart';
import 'package:zawiid/ApiService/OfferService/GetAllOfferApi.dart';
import 'package:zawiid/Classes/offer/offer.dart';


class OfferProvider with ChangeNotifier {

  List<Offer> _allOffer = [];
  List<Offer> get allOffer => _allOffer;
  getAllOffer() async {
    final res = await fetchAllOffer();
    _allOffer = res;
    notifyListeners();
  }


}