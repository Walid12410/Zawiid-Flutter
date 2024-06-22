import 'package:flutter/foundation.dart';
import 'package:zawiid/ApiService/UserInformationService/UserApi.dart';
import 'package:zawiid/Classes/UserDetails/UserDetails.dart';


class UserProvider with ChangeNotifier {

  List<UserInformation> _userInfo = [];
  List<UserInformation> get userInfo => _userInfo;
  getUserInfo(int id) async {
    final res = await fetchUserDetailsById(id);
    _userInfo = res;
    notifyListeners();
  }

}
