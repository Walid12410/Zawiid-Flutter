import 'package:flutter/foundation.dart';
import 'package:zawiid/ApiService/Bid/BidApi.dart';
import 'package:zawiid/ApiService/Bid/BidByIdApi.dart';
import 'package:zawiid/Classes/Bid/Bid.dart';
import 'package:zawiid/Classes/Bid/bidProduct.dart';


class BidProvider with ChangeNotifier {

  List<BidProduct> _bidView = [];
  List<BidProduct> get bidView => _bidView;
  getAllBid() async {
    final res = await fetchAllBid();
    _bidView = res;
    notifyListeners();
  }

  List<Bid> _bidById = [];
  List<Bid> get bidById => _bidById;
  getBidById(int id) async {
    final res = await fetchBidById(id);
    _bidById = res;
    notifyListeners();
  }
}
