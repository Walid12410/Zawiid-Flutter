import 'package:flutter/foundation.dart';
import 'package:zawiid/ApiService/BidService//BidApi.dart';
import 'package:zawiid/ApiService/BidService/BidByIdApi.dart';
import 'package:zawiid/ApiService/BidService/BidZawidLastAmtApi.dart';
import 'package:zawiid/Classes/Bid/BIdZawid.dart';
import 'package:zawiid/Classes/Bid/Bid.dart';
import 'package:zawiid/Classes/Bid/bidProduct.dart';

import '../ApiService/BidService/UserLatestBid.dart';


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

  List<BidZawid> _latestBid = [];
  List<BidZawid> get latestBid => _latestBid;
  getLatestBid(int id) async {
    final res = await fetchLatestBid(id);
    _latestBid = res ;
    notifyListeners();
  }

  List<BidZawid> _latestUserBid = [];
  List<BidZawid> get latestUserBid => _latestUserBid;
  getLatestUserBid(int userNo , int bidNo) async {
    final res = await fetchLatestUserBid(userNo,bidNo);
    _latestUserBid = res ;
    notifyListeners();
  }

}
