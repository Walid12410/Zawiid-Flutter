import 'package:flutter/cupertino.dart';
import 'package:zawiid/Api/BannerService.dart';
import 'package:zawiid/model/Banner/Banner.dart';

class BannerProvider extends ChangeNotifier {
  BannerService service = BannerService();

  List<BannerModel> _banners = [];
  List<BannerModel> get banners => _banners;
  getAllBanner() async {
    final res = await service.fetchBanners();
    _banners = res;
    notifyListeners();
  }

}
