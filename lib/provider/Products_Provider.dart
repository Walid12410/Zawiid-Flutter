import 'package:flutter/foundation.dart';
import 'package:zawiid/ApiService/FeaturedService/FeaturedProductApi.dart';
import 'package:zawiid/ApiService/ProductService/ProductApi.dart';
import 'package:zawiid/ApiService/ProductService/ProductByIdApi.dart';
import 'package:zawiid/ApiService/ProductService/ProductOnSaleApi.dart';
import 'package:zawiid/ApiService/ProductService/ProductTopRated.dart';
import 'package:zawiid/Classes/Featured/Featured.dart';
import 'package:zawiid/Classes/Product/Products.dart';

class ProductsProvider with ChangeNotifier {

  List<Product> _categoryProducts = [];
  List<Product> get categoryProduct => _categoryProducts;
  getAllCategoryProducts(int id) async {
    final res = await fetchProductByCategoryNo(id);
    _categoryProducts = res;
    notifyListeners();
  }

  List<Product> _categoryProductsHome = [];
  List<Product> get categoryProductHome => _categoryProductsHome;
  getAllCategoryProductsHome(int id) async {
    final res = await fetchProductByCategoryNo(id);
    _categoryProductsHome = res;
    notifyListeners();
  }

  List<Featured> _featuredProduct = [];
  List<Featured> get featuredProduct => _featuredProduct;
  getAllFeaturedProduct() async {
    final res = await fetchFeaturedProducts();
    _featuredProduct = res;
    notifyListeners();
  }

  List<Featured> _featuredProductCard = [];
  List<Featured> get featuredProductCard => _featuredProductCard;
  getAllFeaturedProductCard() async {
    final res = await fetchFeaturedProducts();
    _featuredProductCard = res;
    notifyListeners();
  }

  List<Product> _productOnSale = [];
  List<Product> get productOnSale => _productOnSale;
  getProductsOnSale() async {
    final res = await fetchProductOnSale();
    _productOnSale = res;
    notifyListeners();
  }

  List<Product> _productTopRated = [];
  List<Product> get productTopRated => _productTopRated;
  getProductsTopRated() async {
    final res = await fetchProductTopRated();
    _productTopRated = res;
    notifyListeners();
  }

  List<Product> _productById = [];
  List<Product> get productById => _productById;
  getProductById(int id) async {
    final res = await fetchProductById(id);
    _productById = res;
    notifyListeners();
  }

}
