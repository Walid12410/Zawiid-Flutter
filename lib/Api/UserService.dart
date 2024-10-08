import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zawiid/core/config.dart';
import 'package:zawiid/model/UserDetails/UserDetails.dart';


class UserService{
  Future<bool> updateUserProfile(
    int id,
    String firstName,
    String lastName,
    String birthDate,
    String gender,
    String govNo,
    String areaNo,
    ) async {
  final url = Uri.parse('${ApiEndpoints.localBaseUrl}/webUser.php?status=update&id=$id');

  try {
    final response = await http.post(
      url,
      body: {
        'FirstName': firstName,
        'LastName': lastName,
        'BirthDate': birthDate,
        'Gender': gender,
        'GovNo': govNo,
        'AreaNo': areaNo,
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

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


}