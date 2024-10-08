import 'package:flutter/foundation.dart';
import 'package:zawiid/Api/WithDrawalService.dart';
import 'package:zawiid/model/WithDrawal/TotalWithDrawal.dart';
import 'package:zawiid/model/WithDrawal/withDrawalMain.dart';


class TicketProvider with ChangeNotifier {
  WithDrawalService service = WithDrawalService();

  List<Ticket> _allTicket = [];
  List<Ticket> get allTicket => _allTicket;
  getAllTicket() async {
    final res = await service.fetchAllTicket();
    _allTicket = res;
    notifyListeners();
  }


  List<TotalWithDrawl> _totalWithDL = [];
  List<TotalWithDrawl> get totalWithDL => _totalWithDL;
  getTotalWithDrawlByUser(int id, int withDrawlId) async {
    final res = await service.fetchTotalWithDrawl(id,withDrawlId);
    _totalWithDL = res;
    notifyListeners();
  }

}
