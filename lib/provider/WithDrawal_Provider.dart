import 'package:flutter/foundation.dart';
import 'package:zawiid/ApiService/withDrawalService/withDrawalMainApi.dart';
import 'package:zawiid/Classes/WithDrawal/withDrawalMain.dart';


class TicketProvider with ChangeNotifier {

  List<WithdrawalMain> _allTicket = [];
  List<WithdrawalMain> get allTicket => _allTicket;
  getAllTicket() async {
    final res = await fetchAllTicket();
    _allTicket = res;
    notifyListeners();
  }

}
