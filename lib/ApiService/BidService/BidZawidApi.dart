import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/ApiService/BidService/BidAmtUpdateApi.dart';

import 'package:zawiid/Color&Icons/color.dart';


Future<void> addBidZawid(
    BuildContext context, int bidNo, int userNo, String zawidAmt) async {
  String url = '${ApiEndpoints.localBaseUrl}/webBidzawid.php?status=new';

  String zawidDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  try {
    final response = await http.post(
      Uri.parse(url),
      body: {
        'BidNo': bidNo.toString(),
        'UserNo': userNo.toString(),
        'ZawidAmt': zawidAmt,
        'ZawidDate': zawidDate,
      },
    );

    final jsonResponse = json.decode(response.body);
    if (response.statusCode == 200 && jsonResponse['message'] != null) {
      updateBidAmt(bidNo, zawidAmt);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Bid entry has been successfully added.',
            style: TextStyle(fontSize: 10.sp, color: tdWhite),
          ),
          backgroundColor: tdBlack,
          duration: const Duration(seconds: 5),
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
