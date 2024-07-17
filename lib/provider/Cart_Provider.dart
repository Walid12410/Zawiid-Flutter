import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/ApiService/CartService/CartApi.dart';
import 'package:zawiid/ApiService/CartService/CheckProductApi.dart';
import 'package:zawiid/Classes/Cart/Cart.dart';
import 'package:http/http.dart' as http;

class CartProvider with ChangeNotifier {
  List<Cart> _cartUser = [];
  List<Cart> get cartUser => _cartUser;
  getAllCartOfUser(int id) async {
    final res = await fetchCartByUserNo(id);
    _cartUser = res;
    notifyListeners();
  }

  Future<Map<String, dynamic>> validatePromoCode(
      int userNo, String promoCode, double orderTotal) async {
    final response = await http.post(
      Uri.parse('${ApiEndpoints.localBaseUrl}/mobileCheckPromeCode.php'),
      body: {
        'UserNo': userNo.toString(),
        'PromoCode': promoCode.toString(),
        'OrderTotal': orderTotal.toString(),
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {'valid': false};
    }
  }

  Future<bool> createOrder(
      int userNo,
      String orderStartDate,
      String orderSubmitDate,
      int shipToAddressNo,
      String? promoCode,
      double savings) async {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final DateFormat dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    final formattedOrderStartDate =
        dateFormat.format(DateTime.parse(orderStartDate));
    final formattedOrderSubmitDate =
        dateTimeFormat.format(DateTime.parse(orderSubmitDate));
    final orderDetails = _cartUser.map((item) {
      double productPrice = double.parse(item.productCartPrice);
      double productDiscountAmt = productPrice * (savings / 100);
      return {
        'ProductNo': item.productNo,
        'ProductPrice': productPrice.toString(),
        'ProductDiscountAmt': productDiscountAmt.toString(),
        'ProductQty': item.productCartQty.toString(),
      };
    }).toList();

    try {
      final response = await http.post(
        Uri.parse('${ApiEndpoints.localBaseUrl}/mobileCreateOrder.php'),
        body: {
          'OrderStartDate': formattedOrderStartDate,
          'UserNo': userNo.toString(),
          'OrderSubmitDate': formattedOrderSubmitDate,
          'DiscountAmt': savings.toString(),
          'ShipToAddressNo': shipToAddressNo.toString(),
          'PromoCode': promoCode ?? '',
          'OrderDetails': json.encode(orderDetails),
          'Status': 'new',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['message'].contains('successfully added')) {
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

  double get totalPrice {
    double total = 0.0;
    for (var cart in _cartUser) {
      total += double.parse(cart.productCartPrice) * cart.productCartQty;
    }
    return total;
  }

  List<Cart> _viewCartFound = [];
  List<Cart> get viewCartFound => _viewCartFound;
  getIfCartIsAdded(int userId, int productNo) async {
    final res = await fetchProductCartFound(userId, productNo);
    _viewCartFound = res;
    notifyListeners();
  }

  void removeFromCart(int id) {
    _cartUser.removeWhere((cart) => cart.productNo == id);
    notifyListeners();
  }

  void addToCart(int userNo, int productNo, int quantity, String price) {
    _cartUser.add(Cart(
      userNo: userNo,
      productNo: productNo,
      productCartQty: quantity,
      productCartPrice: price.toString(),
    ));
    notifyListeners();
  }

  void clearCart() {
    _cartUser.clear();
    notifyListeners();
  }

  bool isProductInCart(int productNo) {
    return _cartUser.any((cartItem) => cartItem.productNo == productNo);
  }
}
