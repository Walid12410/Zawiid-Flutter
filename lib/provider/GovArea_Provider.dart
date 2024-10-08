import 'package:flutter/cupertino.dart';
import 'package:zawiid/Api/GovAreaService.dart';
import 'package:zawiid/model/GovArea/Governerate.dart';
import '../model/GovArea/Area.dart';

class GovAreaProvider with ChangeNotifier {
  GovAreaService service = GovAreaService();

  List<Governorate> _gov = [];
  List<Governorate> get gov => _gov;
  getAllGov() async {
    final res = await service.fetchAllGov();
    _gov = res;
    notifyListeners();
  }

  List<Area> _area = [];
  List<Area> get area => _area;
  getAllArea() async {
    final res = await service.fetchAllArea();
    _area = res;
    notifyListeners();
  }
}
