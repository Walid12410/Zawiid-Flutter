import 'package:flutter/foundation.dart';
import 'package:zawiid/ApiService/OrderService/OrderByUserApi.dart';

import '../Classes/Order/OrderDetails.dart';


class OrderProvider with ChangeNotifier {

  List<OrderDetails> _orderUser = [];
  List<OrderDetails> get orderUser => _orderUser;
  getOrderByUser(int id) async {
    final res = await fetchOrderByUser(id);
    _orderUser = res;
    notifyListeners();
  }

}
