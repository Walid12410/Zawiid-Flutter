import 'package:flutter/cupertino.dart';
import 'package:zawiid/ApiService/DeliveryService/AllDeliveryOptApi.dart';
import 'package:zawiid/Classes/Delivery/Delivery.dart';

class DeliveryProvider with ChangeNotifier {

  List<DeliveryOption> _allDeliveryOpt = [];
  List<DeliveryOption> get allDeliveryOpt => _allDeliveryOpt;
  getAllDeliveryOptions() async {
    final res = await fetchAllDeliveryOptions();
    _allDeliveryOpt = res;
    notifyListeners();
  }

}