import 'package:flutter/foundation.dart';
import 'package:zawiid/Api/OrderService.dart';
import '../model/Order/OrderDetails.dart';

class OrderProvider with ChangeNotifier {
  OrderService service = OrderService();

  List<OrderDetails> _orderUser = [];
  List<OrderDetails> get orderUser => _orderUser;
  getOrderByUser(int id) async {
    final res = await service.fetchOrderByUser(id);
    _orderUser = res;
    notifyListeners();
  }
}
