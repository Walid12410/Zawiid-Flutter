import 'package:flutter/foundation.dart';
import 'package:zawiid/Api/BidService.dart';
import 'package:zawiid/model/Bid/BIdZawid.dart';
import 'package:zawiid/model/Bid/Bid.dart';
import 'package:zawiid/model/Bid/bidProduct.dart';


class BidProvider with ChangeNotifier {
  BidService bid = BidService();


  // bid pagination upcoming
  final List<BidProduct> _bidProduct = [];
  bool _isLoading = false;
  int _currentPage = 1;
  final int _perPage = 4;
  bool _hasMoreData = true;

  List<BidProduct> get bidProduct => _bidProduct;
  bool get isLoading => _isLoading;
  bool get hasMoreData => _hasMoreData;

  Future<void> getAllBid() async {
    if (_isLoading || !_hasMoreData) return; // Prevent multiple calls
    _isLoading = true;
    notifyListeners();

    try {
      List<BidProduct> newBid = await bid.fetchAllBid(_currentPage, _perPage);

      // Check if there are fewer products than the requested page size
      if (newBid.isEmpty || newBid.length < _perPage) {
        _hasMoreData = false; // No more data available
      } else {
        _currentPage++; // Move to the next page
      }

      // Add only unique products to the list
      for (var bid in newBid) {
        if (!_bidProduct.any((existingProduct) =>
            existingProduct.bidNo == bid.productNo)) {
          _bidProduct.add(bid);
        }
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      _isLoading = false; // Mark loading as completed
      notifyListeners();
    }
  }

  void resetBid() {
    _bidProduct.clear();
    _currentPage = 1;
    _hasMoreData = true;
  }


  // ended bid
  List<BidProduct> _endedBid = [];
  List<BidProduct> get endedBid => _endedBid;
  getEndedBid() async {
    final res = await bid.fetchEndedBid();
    _endedBid = res;
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
