import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';

import '../../Color&Icons/color.dart';

Future<void> updateNbrOfTicketsLeft({
  required int withdrawalID,
  required int nbrOfTicketsLeft,
  required BuildContext context,
}) async {
  String apiUrl = '${ApiEndpoints.localBaseUrl}/webWithDrawalMain.php?status=updateTicketLeft';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'WithdrawalID': withdrawalID.toString(),
        'NbrOfTicketsLeft': nbrOfTicketsLeft.toString(),
      },
    );

    final jsonResponse = json.decode(response.body);
    if (response.statusCode == 200 && jsonResponse['message'] != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Transaction completed successfully',
            style: TextStyle(fontSize: 10.sp, color: tdWhite),
          ),
          backgroundColor: tdBlack,
          duration: const Duration(seconds: 4),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Something went wrong. Check your connection.',
            style: TextStyle(fontSize: 10.sp, color: tdWhite),
          ),
          backgroundColor: tdBlack,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Something went wrong. Check your connection.',
          style: TextStyle(fontSize: 10.sp, color: tdWhite),
        ),
        backgroundColor: tdBlack,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
