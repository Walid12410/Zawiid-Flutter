import 'package:flutter/foundation.dart';
import 'package:zawiid/ApiService/CartService/CartApi.dart';
import 'package:zawiid/ApiService/CartService/CheckProductApi.dart';
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
    cartItem.productCartQty = quantity;
    cartItem.productCartPrice = (price / quantity).toString();
    notifyListeners();
    }

  double get totalPrice {
    double total = 0.0;
    for (var cart in _cartUser) {
      total += double.parse(cart.productCartPrice);
    }
    return total;
  }

  List<Cart> _viewCartFound = [];
  List<Cart> get viewCartFound => _viewCartFound;
  getIfCartIsAdded(int userId,int productNo) async {
    final res = await fetchProductCartFound(userId, productNo);
    _viewCartFound = res;
    notifyListeners();
  }

  void removeFromCart(int id) {
    _cartUser.removeWhere((cart) => cart.productNo == id);
    notifyListeners();
  }

  void addToCart(int userNo,int productNo, int quantity,String price){
    _cartUser.add(Cart(
      userNo: userNo,
      productNo: productNo,
      productCartQty: quantity,
      productCartPrice: price.toString(),
    ));
    notifyListeners();
  }

  void clearCart(){
    _cartUser.clear();
    notifyListeners();
  }

}

