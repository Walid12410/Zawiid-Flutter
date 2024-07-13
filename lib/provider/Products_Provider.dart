import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:zawiid/ApiEndPoint.dart';
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
import 'package:http/http.dart' as http;

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

  List<Product> _productByIdCart = [];

  List<Product> get productByIdCart => _productByIdCart;

  Future<List<Product>> getProductOfCartByUserId(int id) async {
    try {
      final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/webProduct.php?status=one&id=$id'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        _productByIdCart = jsonData.map((json) => Product.fromJson(json)).toList();
        notifyListeners();
        return _productByIdCart;
      } else {
        throw Exception('Failed to load Products');
      }
    } catch (e) {
      throw Exception('Server Error');
    }
  }
}
