import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:zawiid/core/config.dart';
import 'package:zawiid/model/CheckOffer/OfferCheck.dart';
import 'package:zawiid/model/offer/offer.dart';



class OfferService {

Future<OffersData> fetchOfferCheck(int id) async {

  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd', 'en_US').format(now);

  final url = '${ApiEndpoints.localBaseUrl}/MobileApi/mobileCheckOffer.php?status=checkOffer&ProductNo=$id&currentTime=$formattedDate';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      OffersData offersData = OffersData.fromJson(responseData);
      return offersData;
    } else {
      throw Exception('Failed to load offers');
    }
  } catch (error) {
    throw Exception(error);
  }
}

Future<List<Offer>> fetchAllOffer() async {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd', 'en_US').format(now);

  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/MobileApi/mobileTableVW.php?status=offer&currentTime=$formattedDate'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Offer> allOffer = jsonData.map((json) => Offer.fromJson(json)).toList();
      return allOffer;
    } else {
      throw Exception('Failed to load all Offer');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}

}