import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zawiid/Api/FeatureService.dart';
import 'package:zawiid/Api/ProductService.dart';
import 'package:zawiid/model/Featured/Featured.dart';
import 'package:zawiid/model/Product/ProductDetails.dart';
import 'package:zawiid/model/Product/ProductSubCat.dart';
import 'package:zawiid/model/Product/Products.dart';

class ProductsProvider with ChangeNotifier {
  ProductService productService = ProductService();
  FeatureService featureService = FeatureService();

  // sub category product pagination
  final List<ProductSubCategory> _subCategoryProduct = [];
  bool _isLoading = false;
  int _currentPage = 1;
  final int _perPage = 6;
  bool _hasMoreData = true;

  List<ProductSubCategory> get subCategoryProduct => _subCategoryProduct;
  bool get isLoading => _isLoading;
  bool get hasMoreData => _hasMoreData;

Future<void> fetchSubCategoryProduct(int subCatId) async {
  if (_isLoading || !_hasMoreData) return; // Prevent multiple calls
  _isLoading = true;
  notifyListeners();

  try {
    List<ProductSubCategory> newProducts =
        await productService.fetchSubCategoryProduct(subCatId, _currentPage, _perPage);

    // Check if there are fewer products than the requested page size
    if (newProducts.isEmpty || newProducts.length < _perPage) {
      _hasMoreData = false; // No more data available
    } else {
      _currentPage++; // Move to the next page
    }

    // Add only unique products to the list
    for (var product in newProducts) {
      if (!_subCategoryProduct.any((existingProduct) =>
          existingProduct.productNo == product.productNo)) {
        _subCategoryProduct.add(product);
      }
    }

  } catch (e) {
    throw Exception(e);
  } finally {
    _isLoading = false; // Mark loading as completed
    notifyListeners();
  }
}

  void resetSubCategoryProduct() {
    _subCategoryProduct.clear();
    _currentPage = 1;
    _hasMoreData = true;
    //notifyListeners();
  }


  // Top sub category product
  List<ProductSubCategory> _topSubCategoryProducts = [];
  List<ProductSubCategory> get topSubCategoryProducts => _topSubCategoryProducts;
  getTopSubCategoryProduct(int id) async {
    final res = await productService.fetchTopSubCatProduct(id);
    _topSubCategoryProducts = res;
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
