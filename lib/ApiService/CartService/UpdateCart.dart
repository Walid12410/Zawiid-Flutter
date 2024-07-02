import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/provider/Cart_Provider.dart';

import '../../Color&Icons/color.dart';

Future<void> updateCart(int userNo, int productNo, int quantity, double price,
    BuildContext context) async {
  final url = Uri.parse('${ApiEndpoints.localBaseUrl}/webCart.php');

  try {
    final response = await http.post(
      url,
      body: {
        'status': 'update',
        'UserNo': userNo.toString(),
        'ProductNo': productNo.toString(),
        'ProductCartQty': quantity.toString(),
        'ProductCartPrice': price.toString(),
      },
    );

    if (response.statusCode == 200) {
      Provider.of<CartProvider>(context, listen: false)
          .updateCartItem(userNo, productNo, quantity, price);
    }

    final data = json.decode(response.body);
    if (data['error'] != null) {
      throw Exception('Failed to update cart: ${data['error']}');
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
            'Something went wrong.',
            style: TextStyle(
                fontSize: 12.sp, color: tdWhite, fontWeight: FontWeight.bold),
          ),
          backgroundColor: tdBlack,
          duration: const Duration(seconds: 1)),
    );
    throw e;
  }
}
