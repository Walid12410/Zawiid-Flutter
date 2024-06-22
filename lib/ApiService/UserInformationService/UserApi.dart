import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Classes/UserDetails/UserDetails.dart';

Future<List<UserInformation>> fetchUserDetailsById(int id) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/webUser.php?status=one&id=$id'));
    if (response.statusCode == 200) {
      final dynamic jsonData = json.decode(response.body);
      if (jsonData is List) {
        List<UserInformation> userDetails = jsonData.map((json) => UserInformation.fromJson(json)).toList();
        return userDetails;
      } else if (jsonData is Map<String, dynamic>) {
        UserInformation userDetails = UserInformation.fromJson(jsonData);
        return [userDetails];
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to load User Details');
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
