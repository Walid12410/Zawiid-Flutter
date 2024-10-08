import 'dart:convert';

import 'package:http/http.dart' as http;



import 'package:zawiid/core/config.dart';
import 'package:zawiid/model/Product/ProductCategory.dart';
import 'package:zawiid/model/Product/ProductDetails.dart';
import 'package:zawiid/model/Product/Products.dart';

class ProductService {
  
Future<List<ProductCategory>> fetchProductByCategoryNo(int id) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/MobileApi/mobileProductSubCategory.php?id=$id'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<ProductCategory> productsCategory = jsonData.map((json) => ProductCategory.fromJson(json)).toList();
      return productsCategory;
    } else {
      throw Exception('Failed to load products OF Category');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}

Future<List<Product>> fetchProductById(int id) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/webProduct.php?status=one&id=$id'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Product> productsByID = jsonData.map((json) => Product.fromJson(json)).toList();
      return productsByID;
    } else {
      throw Exception('Failed to load Products');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}

Future<List<ProductDetails>> fetchProductDetailsById(int id) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/webProductDetails.php?status=byProductNo&id=$id'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<ProductDetails> productDetailsByID = jsonData.map((json) => ProductDetails.fromJson(json)).toList();
      return productDetailsByID;
    } else {
      throw Exception('Failed to load productDetailsByID');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}

Future<List<Product>> fetchProductOnSale() async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/MobileApi/mobileProductOperation.php?operation=topDiscounted'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Product> productsOnSale = jsonData.map((json) => Product.fromJson(json)).toList();
      return productsOnSale;
    } else {
      throw Exception('Failed to load productsOnSale');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}


Future<List<Product>> fetchProductTopRated() async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/MobileApi/mobileProductOperation.php?operation=random'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Product> productsTopRated = jsonData.map((json) => Product.fromJson(json)).toList();
      return productsTopRated;
    } else {
      throw Exception('Failed to load productsTopRated');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}

}