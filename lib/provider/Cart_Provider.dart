import 'package:flutter/foundation.dart';
import 'package:zawiid/ApiService/CartService/Cart.dart';
import 'package:zawiid/Classes/Cart/Cart.dart';


class CartProvider with ChangeNotifier {

  List<Cart> _cartUser = [];
  List<Cart> get cartUser => _cartUser;
  getAllCartOfUser(int id) async {
    final res = await fetchCartByUserNo(id);
    _cartUser = res;
    notifyListeners();
  }

  void updateCartItem(int userNo, int productNo, int quantity, double price) {
    var cartItem = _cartUser.firstWhere(
          (cart) => cart.userNo == userNo && cart.productNo == productNo
    );
    if (cartItem != null) {
      cartItem.productCartQty = quantity;
      cartItem.productCartPrice = price.toString();
      notifyListeners();
    }
  }

}

