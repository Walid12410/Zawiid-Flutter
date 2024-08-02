import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../ApiEndPoint.dart';


Future<Map<String, dynamic>> validatePromoCode(
    int userNo, String promoCode, double orderTotal) async {
  final response = await http.post(
    Uri.parse('${ApiEndpoints.localBaseUrl}/MobileApi/mobileCheckPromeCode.php'),
    body: {
      'UserNo': userNo.toString(),
      'PromoCode': promoCode.toString(),
      'OrderTotal': orderTotal.toString(),
    },
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return {'valid': false};
  }
}