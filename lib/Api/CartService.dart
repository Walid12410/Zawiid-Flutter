import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/core/config.dart';
import 'package:zawiid/model/Cart/Cart.dart';
import 'package:zawiid/model/Cart/CartDetails.dart';

class CartService {
  Future<void> addCartItem({
    required int userNo,
    required int productNo,
    required int productCartQty,
    required double productCartPrice,
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
        print('success');
      }
    } else {
      throw Exception('Failed to add cart item');
    }
  }

  Future<List<Cart>> fetchCartByUserNo(int id) async {
    try {
      final response = await http.get(Uri.parse(
          '${ApiEndpoints.localBaseUrl}/webCart.php?status=byUserNo&UserNo=$id'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Cart> cartData =
            jsonData.map((json) => Cart.fromJson(json)).toList();
        return cartData;
      } else {
        throw Exception('Failed to load cart Data');
      }
    } catch (e) {
      throw Exception('Server Error');
    }
  }

  Future<List<Cart>> fetchProductCartFound(int userID, int productID) async {
    try {
      final response = await http.get(Uri.parse(
          '${ApiEndpoints.localBaseUrl}/webCart.php?status=one&UserNo=$userID&ProductNo=$productID'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Cart> cartData =
            jsonData.map((json) => Cart.fromJson(json)).toList();
        return cartData;
      } else {
        throw Exception('Failed to load cart Data');
      }
    } catch (e) {
      throw Exception('Server Error');
    }
  }

  Future<void> deleteAllCartItemsByUserNo(int userNo) async {
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
        print('delete success');
      }
    } else {
      throw Exception('Failed to delete cart items');
    }
  }

  Future<void> deleteCartItem({
    required int userNo,
    required int productNo,
  }) async {
    final url = Uri.parse('${ApiEndpoints.localBaseUrl}/webCart.php');

    final response = await http.post(
      url,
      body: {
        'status': 'delete',
        'UserNo': userNo.toString(),
        'ProductNo': productNo.toString(),
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw Exception(responseData['error']);
      } else {
        print('success');
      }
    } else {
      throw Exception('Failed to delete cart item');
    }
  }

  Future<bool> deleteCart(int userNo, int productNo) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiEndpoints.localBaseUrl}/webCart.php'),
        body: {
          'status': 'delete',
          'UserNo': userNo.toString(),
          'ProductNo': productNo.toString(),
        },
      );
      if (response.statusCode == 200) {
        final responseBody = response.body;
        if (responseBody.contains('error')) {
          return false;
        }
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<List<CartDetails>> fetchAllCartDetailsByUser(int id) async {
    try {
      final response = await http.get(Uri.parse(
          '${ApiEndpoints.localBaseUrl}/MobileApi/mobileTableVW.php?status=userCart&UserNo=$id'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<CartDetails> cartData =
            jsonData.map((json) => CartDetails.fromJson(json)).toList();
        return cartData;
      } else {
        throw Exception('Failed to load cart Data');
      }
    } catch (e) {
      throw Exception('Server Error');
    }
  }

  Future<void> updateCart(int userNo, int productNo, int quantity) async {
    final url = Uri.parse('${ApiEndpoints.localBaseUrl}/webCart.php');
    try {
      final response = await http.post(
        url,
        body: {
          'status': 'update',
          'UserNo': userNo.toString(),
          'ProductNo': productNo.toString(),
          'ProductCartQty': quantity.toString(),
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['error'] != null) {
          throw Exception('Failed to update cart: ${data['error']}');
        }
      } else {
        throw Exception('Failed to update cart: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
