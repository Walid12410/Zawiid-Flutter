import 'package:flutter/cupertino.dart';
import 'package:zawiid/ApiService/GovArea/AreaApi.dart';
import 'package:zawiid/ApiService/GovArea/GovApi.dart';
import 'package:zawiid/Classes/GovArea/Governerate.dart';
import '../Classes/GovArea/Area.dart';

class GovAreaProvider with ChangeNotifier {

  List<Governorate> _gov = [];
  List<Governorate> get gov => _gov;
  getAllGov() async {
    final res = await fetchAllGov();
    _gov = res;
    notifyListeners();
  }

  List<Area> _area = [];
  List<Area> get area => _area;
  getAllArea() async {
    final res = await fetchAllArea();
    _area = res;
    notifyListeners();
  }


}