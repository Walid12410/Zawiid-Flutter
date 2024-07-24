import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:zawiid/ApiEndPoint.dart';
import '../../Classes/CheckOffer/OfferCheck.dart';


Future<OffersData> fetchOfferCheck(int id) async {

  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(now);


  final url = '${ApiEndpoints.localBaseUrl}/mobileCheckOffer.php?status=checkOffer&ProductNo=$id&currentTime=$formattedDate';

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