import 'package:flutter/cupertino.dart';
import 'package:zawiid/ApiService/OfferService/CheckIfOfferApi.dart';
import 'package:zawiid/ApiService/OfferService/GetAllOfferApi.dart';
import 'package:zawiid/Classes/CheckOffer/OfferResponse.dart';
import 'package:zawiid/Classes/offer/offer.dart';

class OfferProvider with ChangeNotifier {

  List<Offer> _allOffer = [];
  List<Offer> get allOffer => _allOffer;
  getAllOffer() async {
    final res = await fetchAllOffer();
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

  getOfferCheck(int id) async{
    final res = await fetchOfferCheck(id);
    _offerCheck = res.offers;
    notifyListeners();
  }




}