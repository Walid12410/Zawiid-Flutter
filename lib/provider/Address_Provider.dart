import 'package:flutter/foundation.dart';
import 'package:zawiid/ApiService/AddressService/ViewAddressApi.dart';
import 'package:zawiid/Classes/Address/Address.dart';



class AddressProvider with ChangeNotifier {

  List<Address> _addressView = [];
  List<Address> get addressView => _addressView;
  getAddressByUserId(int id) async {
    final res = await fetchAddressOfUser(id);
    _addressView = res;
    notifyListeners();
  }


  void removeAddress(int id) {
    _addressView.removeWhere((address) => address.addressNo == id);
    notifyListeners();
  }

}
