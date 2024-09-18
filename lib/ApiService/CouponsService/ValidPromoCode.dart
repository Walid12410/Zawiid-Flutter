import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../ApiEndPoint.dart';


Future<Map<String, dynamic>> validatePromoCode(
    int userNo, String promoCode, double orderTotal) async {

  final DateFormat dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss', 'en_US');


  final response = await http.post(
    Uri.parse('${ApiEndpoints.localBaseUrl}/MobileApi/mobileCheckPromeCode.php'),
    body: {
      'UserNo': userNo.toString(),
      'PromoCode': promoCode.toString(),
      'OrderTotal': orderTotal.toString(),
      'UserCurrentDate' : dateTimeFormat.toString()
    },
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return {'valid': false};
  }
}