import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:zawiid/ApiEndPoint.dart';

import '../../provider/Cart_Provider.dart';

Future<void> addCartItem({
  required int userNo,
  required int productNo,
  required int productCartQty,
  required double productCartPrice,
  required BuildContext context
}) async {
  final url = Uri.parse('${ApiEndpoints.localBaseUrl}/webCart.php');

  final response = await http.post(
    url,
    body: {
      'status': 'new',
      'UserNo': userNo.toString(),
      'ProductNo': productNo.toString(),
      'ProductCartQty': productCartQty.toString(),
      'ProductCartPrice': productCartPrice.toString(),
    },
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    if (responseData['error'] != null) {
      throw Exception(responseData['error']);
    } else {
      Provider.of<CartProvider>(context, listen: false).addToCart(userNo, productNo, productCartQty, productCartPrice.toString());
    }
  } else {
    throw Exception('Failed to add cart item');
  }
}
