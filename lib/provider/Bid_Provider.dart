import 'package:flutter/foundation.dart';
import 'package:zawiid/Api/BidService.dart';
import 'package:zawiid/model/Bid/BIdZawid.dart';
import 'package:zawiid/model/Bid/Bid.dart';
import 'package:zawiid/model/Bid/bidProduct.dart';


class BidProvider with ChangeNotifier {
  BidService bid = BidService();


  List<BidProduct> _bidView = [];
  List<BidProduct> get bidView => _bidView;
  getAllBid() async {
    final res = await bid.fetchAllBid();
    _bidView = res;
    notifyListeners();
  }

  List<Bid> _bidById = [];
  List<Bid> get bidById => _bidById;
  getBidById(int id) async {
    final res = await bid.fetchBidById(id);
    _bidById = res;
    notifyListeners();
  }

  List<BidZawid> _latestBid = [];
  List<BidZawid> get latestBid => _latestBid;
  getLatestBid(int id) async {
    final res = await bid.fetchLatestBid(id);
    _latestBid = res ;
    notifyListeners();
  }

  List<BidZawid> _latestUserBid = [];
  List<BidZawid> get latestUserBid => _latestUserBid;
  getLatestUserBid(int userNo , int bidNo) async {
    final res = await bid.fetchLatestUserBid(userNo,bidNo);
    _latestUserBid = res ;
    notifyListeners();
  }

}
