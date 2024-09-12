import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import 'BidAmtUpdateApi.dart';

Future<bool> addBid(BuildContext context, int bidNo, int userNo, String zawidAmt) async {

  String url = '${ApiEndpoints.localBaseUrl}/MobileApi/mobileAddToBid.php';
  String date = DateFormat('yyyy-MM-dd HH:mm:ss', 'en_US').format(DateTime.now());

  try {
    final response = await http.post(
      Uri.parse(url),
      body: {
        'BidNo': bidNo.toString(),
        'UserNo': userNo.toString(),
        'ZawidAmt': zawidAmt,
        'ZawidDate': date,
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['error'] == false && jsonResponse['message'] != null) {
        updateBidAmt(bidNo, zawidAmt);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
