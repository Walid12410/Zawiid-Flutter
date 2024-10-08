import 'package:flutter/foundation.dart';
import 'package:zawiid/Api/CategoryService.dart';

import '../model/Categories/Category.dart';

class CategoryProvider with ChangeNotifier {
  CategoryService catService = CategoryService();

  List<Categories> _category = [];
  List<Categories> get category => _category;
  getCategory() async {
    final res = await catService.fetchCategories();
    _category = res;
    notifyListeners();
  }
}
