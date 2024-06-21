import 'package:flutter/foundation.dart';
import 'package:zawiid/ApiService/ProductService/ProductApi.dart';
import 'package:zawiid/Classes/Product/Products.dart';



class ProductsProvider with ChangeNotifier {

  List<Product> _categoryProducts = [];
  List<Product> get categoryProduct => _categoryProducts;
  getAllCategoryProducts(int id) async {
    final res = await fetchProductByCategoryNo(id);
    _categoryProducts = res;
    notifyListeners();
  }

}
