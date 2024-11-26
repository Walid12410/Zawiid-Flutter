import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:zawiid/model/Product/ProductSubCat.dart';
import 'package:zawiid/provider/Products_Provider.dart';
import '../../Widget/ProductSubCatCard.dart';
import 'Details/ItemViewHead.dart';
import 'Details/ItemViewSearchBar.dart';
import 'Details/LoadingCategoryItem.dart';

class ItemViewCategories extends StatefulWidget {
  const ItemViewCategories({
    Key? key,
    required this.title,
    required this.categoryId,
  }) : super(key: key);

  final String title;
  final int categoryId;

  @override
  State<ItemViewCategories> createState() => _ItemViewCategoriesState();
}

class _ItemViewCategoriesState extends State<ItemViewCategories> {
  late ScrollController _scrollController;
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  late ProductsProvider productsProvider;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productsProvider.fetchSubCategoryProduct(widget.categoryId);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    productsProvider = Provider.of<ProductsProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchController.dispose();
    _debounce?.cancel();
    productsProvider.resetSubCategoryProduct();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 200 &&
        !productsProvider.isLoading) {
      productsProvider.fetchSubCategoryProduct(widget.categoryId);
    }
  }

  List<ProductSubCategory> getFilteredProducts(
      List<ProductSubCategory> products, String query) {
    if (query.isEmpty) {
      return products; // If no search query, return all products
    }
    return products
        .where((product) =>
            product.productName.toLowerCase().contains(query.toLowerCase()) ||
            product.productDesc.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: Consumer<ProductsProvider>(
          builder: (context, provider, child) {
            // Filter products based on the search query
            final filteredProducts =
                getFilteredProducts(provider.subCategoryProduct, searchQuery);

            // If still loading and no products, show loading indicator
            if (provider.isLoading && provider.subCategoryProduct.isEmpty) {
              return const LoadingCategoryItem();
            }

            return Column(
              children: [
                ItemCategoriesHead(title: widget.title),
                SizedBox(height: 5.h),
                ItemSearchBar(
                  controller: searchController,
                  onSearch: (value) {
                    if (_debounce?.isActive ?? false) _debounce?.cancel();
                    _debounce =
                        Timer(const Duration(milliseconds: 300), () async {
                      if (mounted) {
                        setState(() {
                          searchQuery = value;
                        });
                        // Call fetchSubCategoryProduct whenever search query changes
                        if (value.isNotEmpty) {
                          await productsProvider
                              .fetchSubCategoryProduct(widget.categoryId);
                        }
                      }
                    });
                  },
                ),
                if (filteredProducts.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(20).w,
                    child: Center(
                      child: Text(
                        S.of(context).productNotFound,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: tdGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 20.h),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: (filteredProducts.length / 2).ceil() +
                        (provider.hasMoreData ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == (filteredProducts.length / 2).ceil()) {
                        return provider.hasMoreData
                            ? Padding(
                                padding: const EdgeInsets.all(4).w,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: tdBlack,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink();
                      }
                      return _buildProductRow(filteredProducts, index * 2);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductRow(List<ProductSubCategory> products, int startIndex) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(child: _buildProductCard(products[startIndex])),
          if (startIndex + 1 < products.length)
            Flexible(child: _buildProductCard(products[startIndex + 1])),
        ],
      ),
    );
  }

  Widget _buildProductCard(ProductSubCategory product) {
    return Padding(
        padding: EdgeInsets.all(5.w),
        child: SubCategoryProductCard(product: product));
  }
}
