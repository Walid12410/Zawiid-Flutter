import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:zawiid/Api/CartService.dart';
import 'package:zawiid/core/config.dart';
import 'package:zawiid/model/Cart/Cart.dart';
import 'package:http/http.dart' as http;
import 'package:zawiid/model/Cart/CartDetails.dart';

class CartProvider with ChangeNotifier {

  CartService cartServices = CartService();


  List<Cart> _cartUser = [];
  List<Cart> get cartUser => _cartUser;
  getAllCartOfUser(int id) async {
    final res = await cartServices.fetchCartByUserNo(id);
    _cartUser = res;
    notifyListeners();
  }

  Future<void> updateCartItem(int userNo, int productNo, int quantity, double price) async {
    try {
      await cartServices.updateCart(userNo, productNo, quantity);
      final index = _cartUser.indexWhere((item) => item.productNo == productNo);
      if (index != -1) {
        _cartUser[index].productCartQty = quantity;
        _cartUser[index].productCartPrice = price.toString();
        _cartDetailsUser[index].productCartQty = quantity;
        _cartDetailsUser[index].productCartPrice = price.toString();
        notifyListeners();
      }
    } catch (error) {
      throw Exception('Failed to update cart item: $error');
    }
  }

  Future<void> deleteCartItem(int userNo, int productNo) async {
    try {
      final success = await cartServices.deleteCart(userNo, productNo);
      if (success) {
        _cartDetailsUser.removeWhere((cart) => cart.productNo == productNo);
        _cartUser.removeWhere((cart) => cart.productNo == productNo);
        notifyListeners();
      } else {
        throw Exception('Failed to delete cart item');
      }
    } catch (error) {
      throw Exception('Failed to delete cart item: $error');
    }
  }

  List<CartDetails> _cartDetailsUser = [];
  List<CartDetails> get cartDetailsUser => _cartDetailsUser;
  getAllCartDetailsOfUser(int id) async {
    final res = await cartServices.fetchAllCartDetailsByUser(id);
    _cartDetailsUser = res;
    notifyListeners();
  }

  void clearCartDetails() {
    _cartDetailsUser.clear();
    notifyListeners();
  }


  Future<bool> createOrder(
      int userNo,
      String orderStartDate,
      String orderSubmitDate,
      int shipToAddressNo,
      String? promoCode,
      double savings,
      String validFor,
      int deliveryOption) async {

    final DateFormat dateFormat = DateFormat('yyyy-MM-dd', 'en_US');
    final DateFormat dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss', 'en_US');

    DateTime startDate;
    DateTime submitDate;

    try {
      startDate = DateTime.parse(orderStartDate);
      submitDate = DateTime.parse(orderSubmitDate);
    } catch (e) {
      return false;
    }

    final formattedOrderStartDate = dateFormat.format(startDate);
    final formattedOrderSubmitDate = dateTimeFormat.format(submitDate);

    final orderDetails = _cartDetailsUser.map((item) {
      double productPrice;
      try {
        productPrice = double.parse(item.productCartPrice);
        if (productPrice < 0) {
          throw const FormatException('Negative price');
        }
      } catch (e) {
        productPrice = 0; // Default to 0 or handle as needed
      }

      double productDiscountAmt = 0;
      if (validFor == "Everything" || validFor == item.markName) {
        productDiscountAmt = productPrice * (savings / 100);
      }

      return {
        'ProductNo': item.productNo.toString(),
        'ProductPrice': productPrice.toStringAsFixed(2), // Format price to 2 decimal places
        'ProductDiscountAmt': productDiscountAmt.toStringAsFixed(2), // Format discount to 2 decimal places
        'ProductQty': item.productCartQty.toString(),
      };
    }).toList();

    // Make HTTP request
    try {
      final response = await http.post(
        Uri.parse('${ApiEndpoints.localBaseUrl}/MobileApi/mobileCreateOrder.php'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'}, // Added headers for form encoding
        body: {
          'OrderStartDate': formattedOrderStartDate,
          'UserNo': userNo.toString(),
          'OrderSubmitDate': formattedOrderSubmitDate,
          'DiscountAmt': savings.toStringAsFixed(2),
          'ShipToAddressNo': shipToAddressNo.toString(),
          'PromoCode': promoCode ?? '',
          'OrderDetails': json.encode(orderDetails),
          'Status': 'new',
          if (deliveryOption != 0) 'DeliveryOptions': deliveryOption.toString(),
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final message = data['message'] ?? '';
        if (message.contains('successfully added')) {
          clearCartDetails();
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
    final res = await cartServices.fetchProductCartFound(userId, productNo);
    _viewCartFound = res;
    notifyListeners();
  }

  void removeFromCart(int id) {
    _cartUser.removeWhere((cart) => cart.productNo == id);
    _cartDetailsUser.removeWhere((cart)=> cart.productNo == id);
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

  void clearCartsDetails() {
    _cartDetailsUser.clear();
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
