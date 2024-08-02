import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Classes/WithDrawal/TotalWithDrawal.dart';

Future<List<TotalWithDrawl>> fetchTotalWithDrawl(int userId, int withDrawlId) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/MobileApi/mobileTotalNbsWithDrawal.php?userNo=$userId&WithDrawalID=$withDrawlId'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<TotalWithDrawl> totalWithDrawl = jsonData.map((json) => TotalWithDrawl.fromJson(json)).toList();
      return totalWithDrawl;
    } else {
      throw Exception('Failed to load total WithDrawl by userId');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}
