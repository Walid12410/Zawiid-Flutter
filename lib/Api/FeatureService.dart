import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:zawiid/core/config.dart';
import 'package:zawiid/model/Featured/Featured.dart';

class FeatureService {
  Future<List<FeaturedProduct>> fetchFeaturedProducts() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd', 'en_US').format(now);

    try {
      final response = await http.get(Uri.parse(
          '${ApiEndpoints.localBaseUrl}/MobileApi/mobileTableVW.php?status=feature&currentTime=$formattedDate'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<FeaturedProduct> featuredProduct =
            jsonData.map((json) => FeaturedProduct.fromJson(json)).toList();
        return featuredProduct;
      } else {
        throw Exception('Failed to load featuredProduct');
      }
    } catch (e) {
      throw Exception('Server Error');
    }
  }
}
