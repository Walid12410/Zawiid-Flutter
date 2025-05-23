import 'dart:convert';
import 'package:zawiid/core/config.dart';
import 'package:zawiid/model/Banner/Banner.dart';
import 'package:http/http.dart' as http;


class BannerService {

  Future<List<BannerModel>> fetchBanners() async {
    try {
      final response = await http.get(Uri.parse(
          '${ApiEndpoints.localBaseUrl}/webBanner.php?status=select'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<BannerModel> categories =
        jsonData.map((json) => BannerModel.fromJson(json)).toList();
        return categories;
      } else {
        throw Exception('Failed to load Banners');
      }
    } catch (e) {
      throw Exception('Server Error');
    }
  }

}
