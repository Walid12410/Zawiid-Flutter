import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/provider/Cart_Provider.dart';

Future<void> deleteAllCartItemsByUserNo(int userNo,BuildContext context) async {
  final url = Uri.parse('${ApiEndpoints.localBaseUrl}/webCart.php');

  final response = await http.post(
    url,
    body: {
      'status': 'deleteByUserNo',
      'UserNo': userNo.toString(),
    },
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    if (responseData['error'] != null) {
      throw Exception(responseData['error']);
    } else {
      Provider.of<CartProvider>(context, listen: false).clearCart();
    }
  } else {
    throw Exception('Failed to delete cart items');
  }
}
