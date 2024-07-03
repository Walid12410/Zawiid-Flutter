import 'package:flutter/foundation.dart';
import 'package:zawiid/ApiService/MarkColorService/ColorByIdApi.dart';
import 'package:zawiid/ApiService/MarkColorService/MarkByIdApi.dart';
import 'package:zawiid/Classes/ColorAndMark/color.dart';
import 'package:zawiid/Classes/ColorAndMark/mark.dart';



class MarkColorProvider with ChangeNotifier {


  List<ColorProduct> _oneColorByID = [];
  List<ColorProduct> get oneColorByID => _oneColorByID;
  getColorById(int id) async {
    final res = await fetchColorById(id);
    _oneColorByID = res;
    notifyListeners();
  }

  List<Mark> _oneMarkByID = [];
  List<Mark> get oneMarkByID => _oneMarkByID;
  getMarkById(int id) async {
    final res = await fetchMarkById(id);
    _oneMarkByID = res;
    notifyListeners();
  }

  List<ColorProduct> _oneColorByIDBid = [];
  List<ColorProduct> get oneColorByIDBid => _oneColorByIDBid;
  getColorByIdBid(int id) async {
    final res = await fetchColorById(id);
    _oneColorByIDBid = res;
    notifyListeners();
  }
  List<ColorProduct> _oneColorByIDTicket = [];
  List<ColorProduct> get oneColorByIDTicket => _oneColorByIDTicket;
  getColorByIdTicket(int id) async {
    final res = await fetchColorById(id);
    _oneColorByIDTicket = res;
    notifyListeners();
  }

  List<Mark> _oneMarkByIDTicket = [];
  List<Mark> get oneMarkByIDTicket => _oneMarkByIDTicket;
  getMarkByIdTicket(int id) async {
    final res = await fetchMarkById(id);
    _oneMarkByIDTicket = res;
    notifyListeners();
  }

  List<Mark> _oneMarkByIDCoupons = [];
  List<Mark> get oneMarkByIDCoupons => _oneMarkByIDCoupons;
  getMarkByIdCoupons(int id) async {
    final res = await fetchMarkById(id);
    _oneMarkByIDCoupons = res;
    notifyListeners();
  }


}
