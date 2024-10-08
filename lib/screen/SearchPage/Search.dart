import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/core/config.dart';
import 'package:zawiid/data/local_database.dart';
import '../../model/Product/Products.dart';
import 'Details/SearchBar.dart';
import 'Details/SearchHistoryCard.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  List<Product> _searchResults = [];
  bool _isSearching = false;
  bool _isLoading = false;
  bool _hasError = false;
  List<Product> _searchHistory = [];

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    _searchController.addListener(_onSearchChanged);
    _loadSearchHistory();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _isSearching = _searchController.text.isNotEmpty;
      _isLoading = true;
      _hasError = false;
    });
    _searchProducts(_searchController.text);
  }

  void _updateSearchResults(List<Product> results) {
    setState(() {
      _searchResults = results;
      _isLoading = false;
    });
  }

  void _searchProducts(String query) async {
    if (query.isEmpty) {
      _updateSearchResults([]);
      return;
    }

    try {
      final response = await http.get(Uri.parse(
          '${ApiEndpoints.localBaseUrl}/MobileApi/mobileSearch.php?productName=$query'));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<Product> products =
        body.map((dynamic item) => Product.fromJson(item)).toList();
        _updateSearchResults(products);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  void _loadSearchHistory() async {
    List<Product> history = await DatabaseHelper().getSearchHistory();
    setState(() {
      _searchHistory = history;
    });
  }

  void _saveProductToHistory(Product product) async {
    await DatabaseHelper().insertProduct(product);
    _loadSearchHistory(); // Refresh the search history
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 12.h),
              Center(
                child: SizedBox(
                  width: 100.w,
                  height: 50.h,
                  child: Image.asset(
                    'assets/log/LOGO-icon---Black.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              SearchBarText(
                focusNode: _focusNode,
                controller: _searchController,
                onSearchResults: _updateSearchResults,
              ),
              SizedBox(height: 25.h),
              if (!_isSearching && _searchHistory.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 8).w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'RECENTLY VIEWED',
                        style: TextStyle(
                            fontSize: 9.sp,
                            color: tdGrey,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                          onTap: () {
                            DatabaseHelper().clearSearchHistory();
                            _loadSearchHistory();
                          },
                          child: Text(
                            'CLEAR',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 9.sp,
                                color: tdBlack),
                          ))
                    ],
                  ),
                ),
              if (!_isSearching)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _searchHistory.map((product) {
                      return SearchHistoryCard(product: product);
                    }).toList(),
                  ),
                ),
              if (_isLoading)
                const Center(
                  child: CircularProgressIndicator(
                    color: tdBlack,
                  ),
                ),
              if (_hasError)
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Something went wrong. Check your connection',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: tdGrey,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              if (_searchResults.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(5).w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _searchResults.map((product) {
                      return Padding(
                        padding: const EdgeInsets.all(5).w,
                        child: GestureDetector(
                          onTap: () {
                            _saveProductToHistory(product);
                            context.push('/itemDetailsView/${product.productNo}/${product.colorNo}/${product.markNo}');
                          },
                          child: SizedBox(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 50.w,
                                  height: 50.h,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                    '${ApiEndpoints.localBaseUrl}/${product.productImage}',
                                    placeholder: (context, url) => Image.asset(
                                        'assets/log/LOGO-icon---Black.png'),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                            'assets/log/LOGO-icon---Black.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.productName,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        '\$${product.price.toString()}',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
