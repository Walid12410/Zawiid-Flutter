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


}
