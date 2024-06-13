import 'package:flutter/foundation.dart';
import 'package:zawiid/ApiService/CategoryService/Categories.dart';

import '../Classes/Categories/Category.dart';


class CategoryProvider with ChangeNotifier {

  List<Categories> _category = [];
  List<Categories> get category => _category;
  getCategory() async {
    final res = await fetchCategories();
    _category = res;
    notifyListeners();
  }

}
