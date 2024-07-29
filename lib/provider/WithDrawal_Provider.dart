import 'package:flutter/foundation.dart';
import 'package:zawiid/ApiService/withDrawalService/TotalWithDrawalApi.dart';
import 'package:zawiid/ApiService/withDrawalService/withDrawalMainApi.dart';
import 'package:zawiid/Classes/WithDrawal/TotalWithDrawal.dart';
import 'package:zawiid/Classes/WithDrawal/withDrawalMain.dart';


class TicketProvider with ChangeNotifier {

  List<WithdrawalMain> _allTicket = [];
  List<WithdrawalMain> get allTicket => _allTicket;
  getAllTicket() async {
    final res = await fetchAllTicket();
    _allTicket = res;
    notifyListeners();
  }


  List<TotalWithDrawl> _totalWithDL = [];
  List<TotalWithDrawl> get totalWithDL => _totalWithDL;
  getTotalWithDrawlByUser(int id, int withDrawlId) async {
    final res = await fetchTotalWithDrawl(id,withDrawlId);
    _totalWithDL = res;
    notifyListeners();
  }

}
