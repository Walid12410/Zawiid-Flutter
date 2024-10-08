import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:zawiid/core/config.dart';
import 'package:zawiid/model/Bid/BIdZawid.dart';
import 'package:zawiid/model/Bid/Bid.dart';
import 'package:zawiid/model/Bid/bidProduct.dart';
import 'package:flutter/material.dart';


class BidService {
  
Future<void> updateBidAmt(int bidNo, String amountToAdd) async {
  final url = Uri.parse("${ApiEndpoints.localBaseUrl}/webUpdateBid.php");
  final response = await http.post(
    url,
    body: {
      'status': 'updateBidAmt',
      'BidNo': bidNo.toString(),
      'amountToAdd': amountToAdd.toString(),
    },
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    print('Response: ${jsonResponse['message']}');
  } else {
    throw Exception('Failed to update bid amount');
  }
}

Future<List<BidProduct>> fetchAllBid() async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/MobileApi/mobileBid.php'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<BidProduct> bidData = jsonData.map((json) => BidProduct.fromJson(json)).toList();
      return bidData;
    } else {
      throw Exception('Failed to load bidData');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}

Future<List<Bid>> fetchBidById(int id) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/webBid.php?status=one&BidNo=$id'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Bid> bidById = jsonData.map((json) => Bid.fromJson(json)).toList();
      return bidById;
    } else {
      throw Exception('Failed to load bidById');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}

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

Future<List<BidZawid>> fetchLatestBid(int bidNo) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/MobileApi/mobileBidZawid.php?status=highestPrice&BidNo=$bidNo'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<BidZawid> latestBid = jsonData.map((json) => BidZawid.fromJson(json)).toList();
      return latestBid;
    } else {
      throw Exception('Failed to load latest Bid');
    }
  } catch (e) {
    throw Exception('Server Error $e');
  }
}

Future<List<BidZawid>> fetchLatestUserBid(int userNo, int bidNo) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/MobileApi/mobileBidZawid.php?status=LastBidUser&UserNo=$userNo&BidNo=$bidNo'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<BidZawid> userLatestBid = jsonData.map((json) => BidZawid.fromJson(json)).toList();
      return userLatestBid;
    } else {
      throw Exception('Failed to load user LatestBid');
    }
  } catch (e) {
    throw Exception('Server Error $e');
  }
}



}