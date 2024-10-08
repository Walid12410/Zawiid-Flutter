import 'package:flutter/cupertino.dart';
import 'package:zawiid/Api/DeliveryService.dart';
import 'package:zawiid/model/Delivery/Delivery.dart';

class DeliveryProvider with ChangeNotifier {
  DeliveryService delivery = DeliveryService();

  List<DeliveryOption> _allDeliveryOpt = [];
  List<DeliveryOption> get allDeliveryOpt => _allDeliveryOpt;

  int optionsSelected = 0;

  DeliveryProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    await getAllDeliveryOptions();
    _setDefaultOption();
  }

  Future<void> getAllDeliveryOptions() async {
    final res = await delivery.fetchAllDeliveryOptions();
    _allDeliveryOpt = res;
    notifyListeners();
    _setDefaultOption();
  }

  void _setDefaultOption() {
    if (_allDeliveryOpt.isNotEmpty) {
      final defaultOption = _allDeliveryOpt.firstWhere(
        (option) => option.isDefault == 1,
        orElse: () => _allDeliveryOpt.first, // Fallback if no default
      );
      optionsSelected = defaultOption.shippingOptionID;
      getOneDeliveryOptions(optionsSelected);
    } else {
      optionsSelected = 0;
    }
    notifyListeners();
  }

  void updateSelectedOption(int newOptionID) {
    optionsSelected = newOptionID;
    notifyListeners();
  }

  List<DeliveryOption> _oneDeliveryOptions = [];
  List<DeliveryOption> get oneDeliveryOptions => _oneDeliveryOptions;
  getOneDeliveryOptions(int id) async {
    final res = await delivery.fetchOneDeliveryOptions(id);
    _oneDeliveryOptions = res;
    notifyListeners();
  }
}
