import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Color&Icons/color.dart';
import '../../provider/User_Provider.dart';
import 'package:zawiid/ApiEndPoint.dart';

Future<void> updateUserProfile(
    BuildContext context,
    int id,
    String firstName,
    String lastName,
    String birthDate,
    String gender,
    String govNo,
    String areaNo,
    ) async {
  final url = Uri.parse(
      '${ApiEndpoints.localBaseUrl}/webUser.php?status=update&id=$id');

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

  try {
    if (response.statusCode == 200) {
      await Provider.of<UserProvider>(context, listen: false).getUserInfo(id);
      GoRouter.of(context).go('/Profile');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Something went wrong, try again later',
            style: TextStyle(fontSize: 10.sp, color: tdWhite),
          ),
          backgroundColor: tdBlack,
          duration: const Duration(seconds: 5),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Something went wrong, try again later',
          style: TextStyle(fontSize: 10.sp, color: tdWhite),
        ),
        backgroundColor: tdBlack,
        duration: const Duration(seconds: 5),
      ),
    );
  }
}
