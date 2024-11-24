import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zawiid/Api/addressService.dart';
import 'package:zawiid/model/Address/Address.dart';

class AddressProvider with ChangeNotifier {
  AddressService address = AddressService();

  List<Address> _addressView = [];
  List<Address> get addressView => _addressView;
  getAddressByUserId(int id) async {
    final res = await address.fetchAddressOfUser(id);
    _addressView = res;
    notifyListeners();
  }

  void removeAddress(int id) {
    _addressView.removeWhere((address) => address.addressNo == id);
    if (id == _defaultAddressNo) {
      removeDefaultAddress();
    }
    notifyListeners();
  }

  int _defaultAddressNo = 0;
  int get defaultAddressNo => _defaultAddressNo;

  AddressProvider() {
    _loadDefaultAddress();
  }

  Future<void> _loadDefaultAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _defaultAddressNo = prefs.getInt('defaultAddressNo') ?? -1;
    notifyListeners();
  }

  Future<void> setDefaultAddress(int addressNo) async {
    _defaultAddressNo = addressNo;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('defaultAddressNo', _defaultAddressNo);
    notifyListeners();
  }

  Future<void> removeDefaultAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('defaultAddressNo');
    _defaultAddressNo = -1;
    notifyListeners();
  }

}
