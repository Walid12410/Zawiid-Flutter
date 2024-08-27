import 'package:flutter/foundation.dart';
import 'package:zawiid/ApiService/FeaturedService/FeaturedProductApi.dart';
import 'package:zawiid/ApiService/ProductService/ProductApi.dart';
import 'package:zawiid/ApiService/ProductService/ProductByIdApi.dart';
import 'package:zawiid/ApiService/ProductService/ProductDetails.dart';
import 'package:zawiid/ApiService/ProductService/ProductOnSaleApi.dart';
import 'package:zawiid/ApiService/ProductService/ProductTopRated.dart';
import 'package:zawiid/Classes/Featured/Featured.dart';
import 'package:zawiid/Classes/Product/ProductCategory.dart';
import 'package:zawiid/Classes/Product/ProductDetails.dart';
import 'package:zawiid/Classes/Product/Products.dart';

class ProductsProvider with ChangeNotifier {

  List<ProductCategory> _categoryProducts = [];

  List<ProductCategory> get categoryProduct => _categoryProducts;

  getAllCategoryProducts(int id) async {
    final res = await fetchProductByCategoryNo(id);
    _categoryProducts = res;
    notifyListeners();
  }

  List<ProductCategory> _categoryProductsHome = [];

  List<ProductCategory> get categoryProductHome => _categoryProductsHome;

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

  List<Product> _productByIdBid = [];

  List<Product> get productByIdBid => _productByIdBid;

  getProductByIdBid(int id) async {
    final res = await fetchProductById(id);
    _productByIdBid = res;
    notifyListeners();
  }


  List<Product> _productByIdTicket = [];

  List<Product> get productByIdTicket => _productByIdTicket;

  getProductByIdTicket(int id) async {
    final res = await fetchProductById(id);
    _productByIdTicket = res;
    notifyListeners();
  }

  List<ProductDetails> _productDetailsById = [];

  List<ProductDetails> get productDetailsById => _productDetailsById;

  getProductDetailsById(int id) async {
    final res = await fetchProductDetailsById(id);
    _productDetailsById = res;
    notifyListeners();
  }

}

