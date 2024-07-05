import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:zawiid/ApiEndPoint.dart';

import '../../Color&Icons/color.dart';

Future<void> addOrUpdateWithdrawalDetails({
  required BuildContext context,
  required int nbrOfTicketsWithdrawn,
  required double ticketsTotalPrice,
  required int withDrawalID,
  required int userNo,
}) async {
  String apiUrl = '${ApiEndpoints.localBaseUrl}/webWithDrawalDetails.php?status=new';

  String detDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'WithDetDate': detDate,
        'NbrOfTicketsWithdrawn': nbrOfTicketsWithdrawn.toString(),
        'TicketsTotalPrice': ticketsTotalPrice.toString(),
        'WithDrawalID': withDrawalID.toString(),
        'UserNo': userNo.toString(),
      },
    );

    final jsonResponse = json.decode(response.body);
    if (response.statusCode == 200 && jsonResponse['message'] != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'success',
            style: TextStyle(fontSize: 10.sp, color: tdWhite),
          ),
          backgroundColor: tdBlack,
          duration: const Duration(seconds: 1),
        ),
      );
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
