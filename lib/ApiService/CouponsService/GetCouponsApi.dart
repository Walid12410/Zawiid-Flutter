import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:zawiid/ApiEndPoint.dart';

Future<bool> getCoupons({
  required int userNo,
  //required String expiryDate,
  required int used,
  required int couponNo,
}) async {
  final url = Uri.parse('${ApiEndpoints.localBaseUrl}/webGetCoupons.php?status=new');


  String getDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  final response = await http.post(
    url,
    body: {
      'UserNo': userNo.toString(),
      'GetDate': getDate,
     // 'ExpiryDate': expiryDate,
      'Used': used.toString(),
      'CouponNo': couponNo.toString(),
    },
  );

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);
    if (responseBody['message'] == 'GetCoupons entry has been successfully added.') {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}
