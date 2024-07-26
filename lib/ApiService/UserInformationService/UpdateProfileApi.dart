import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../Color&Icons/color.dart';
import '../../provider/User_Provider.dart';
import 'package:zawiid/ApiEndPoint.dart';

Future<bool> updateUserProfile(
    BuildContext context,
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
      // Server returned an error response
      return false;
    }
  } catch (e) {
    // Exception occurred during the HTTP request
    return false;
  }
}
