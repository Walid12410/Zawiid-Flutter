import 'package:flutter/foundation.dart';
import 'package:zawiid/Api/FeatureService.dart';
import 'package:zawiid/Api/ProductService.dart';
import 'package:zawiid/model/Featured/Featured.dart';
import 'package:zawiid/model/Product/ProductCategory.dart';
import 'package:zawiid/model/Product/ProductDetails.dart';
import 'package:zawiid/model/Product/Products.dart';

class ProductsProvider with ChangeNotifier {
  ProductService productService = ProductService();
  FeatureService featureService = FeatureService();

  List<ProductCategory> _categoryProducts = [];

  List<ProductCategory> get categoryProduct => _categoryProducts;

  getAllCategoryProducts(int id) async {
    final res = await productService.fetchProductByCategoryNo(id);
    _categoryProducts = res;
    notifyListeners();
  }

  List<ProductCategory> _categoryProductsHome = [];

  List<ProductCategory> get categoryProductHome => _categoryProductsHome;

  getAllCategoryProductsHome(int id) async {
    final res = await productService.fetchProductByCategoryNo(id);
    _categoryProductsHome = res;
    notifyListeners();
  }

  List<Featured> _featuredProduct = [];

  List<Featured> get featuredProduct => _featuredProduct;

  getAllFeaturedProduct() async {
    final res = await featureService.fetchFeaturedProducts();
    _featuredProduct = res;
    notifyListeners();
  }

  List<Featured> _featuredProductCard = [];

  List<Featured> get featuredProductCard => _featuredProductCard;

  getAllFeaturedProductCard() async {
    final res = await featureService.fetchFeaturedProducts();
    _featuredProductCard = res;
    notifyListeners();
  }

  List<Product> _productOnSale = [];

  List<Product> get productOnSale => _productOnSale;

  getProductsOnSale() async {
    final res = await productService.fetchProductOnSale();
    _productOnSale = res;
    notifyListeners();
  }

  List<Product> _productTopRated = [];

  List<Product> get productTopRated => _productTopRated;

  getProductsTopRated() async {
    final res = await productService.fetchProductTopRated();
    _productTopRated = res;
    notifyListeners();
  }

  List<Product> _productById = [];

  List<Product> get productById => _productById;

  getProductById(int id) async {
    final res = await productService.fetchProductById(id);
    _productById = res;
    notifyListeners();
  }

  List<Product> _productByIdBid = [];

  List<Product> get productByIdBid => _productByIdBid;

  getProductByIdBid(int id) async {
    final res = await productService.fetchProductById(id);
    _productByIdBid = res;
    notifyListeners();
  }

  List<Product> _productByIdTicket = [];

  List<Product> get productByIdTicket => _productByIdTicket;

  getProductByIdTicket(int id) async {
    final res = await productService.fetchProductById(id);
    _productByIdTicket = res;
    notifyListeners();
  }

  List<ProductDetails> _productDetailsById = [];

  List<ProductDetails> get productDetailsById => _productDetailsById;

  getProductDetailsById(int id) async {
    final res = await productService.fetchProductDetailsById(id);
    _productDetailsById = res;
    notifyListeners();
  }
}
