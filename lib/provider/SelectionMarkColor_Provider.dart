import 'package:flutter/foundation.dart';
import 'package:zawiid/Api/ColorMarkService.dart';
import 'package:zawiid/model/ColorAndMark/color.dart';
import 'package:zawiid/model/ColorAndMark/mark.dart';

class MarkColorProvider with ChangeNotifier {
  ColorMarkService service = ColorMarkService();

  List<ColorProduct> _oneColorByID = [];
  List<ColorProduct> get oneColorByID => _oneColorByID;
  getColorById(int id) async {
    final res = await service.fetchColorById(id);
    _oneColorByID = res;
    notifyListeners();
  }

  List<Mark> _oneMarkByID = [];
  List<Mark> get oneMarkByID => _oneMarkByID;
  getMarkById(int id) async {
    final res = await service.fetchMarkById(id);
    _oneMarkByID = res;
    notifyListeners();
  }

  List<ColorProduct> _oneColorByIDBid = [];
  List<ColorProduct> get oneColorByIDBid => _oneColorByIDBid;
  getColorByIdBid(int id) async {
    final res = await service.fetchColorById(id);
    _oneColorByIDBid = res;
    notifyListeners();
  }

  List<Mark> _oneMarkByIDCoupons = [];
  List<Mark> get oneMarkByIDCoupons => _oneMarkByIDCoupons;
  getMarkByIdCoupons(int id) async {
    final res = await service.fetchMarkById(id);
    _oneMarkByIDCoupons = res;
    notifyListeners();
  }
}
