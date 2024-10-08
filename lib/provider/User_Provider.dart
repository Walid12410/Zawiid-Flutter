import 'package:flutter/foundation.dart';
import 'package:zawiid/Api/UserService.dart';
import 'package:zawiid/model/UserDetails/UserDetails.dart';

class UserProvider with ChangeNotifier {
  UserService service = UserService();

  List<UserInformation> _userInfo = [];
  List<UserInformation> get userInfo => _userInfo;
  getUserInfo(int id) async {
    final res = await service.fetchUserDetailsById(id);
    _userInfo = res;
    notifyListeners();
  }
}
