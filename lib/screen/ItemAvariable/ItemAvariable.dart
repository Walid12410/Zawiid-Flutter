import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/core/config.dart';
import 'package:zawiid/localization/generated/l10n.dart';
import 'package:zawiid/model/Product/ProductCategory.dart';
import 'package:zawiid/provider/Products_Provider.dart';
import 'Details/CartItemView.dart';
import 'Details/ItemViewHead.dart';
import 'Details/ItemViewSearchBar.dart';

import 'Details/LoadingCategoryItem.dart';

class ItemViewCategories extends StatefulWidget {
  const ItemViewCategories(
      {Key? key, required this.title, required this.categoryId})
      : super(key: key);

  final String title;
  final int categoryId;

  @override
  State<ItemViewCategories> createState() => _ItemViewCategoriesState();
}

class _ItemViewCategoriesState extends State<ItemViewCategories> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  late Future<void> _fetchProductsFuture;

  @override
  void initState() {
    super.initState();
    _fetchProductsFuture = _fetchProducts();
  }



  Future<void> _fetchProducts() async {
    final provider = Provider.of<ProductsProvider>(context, listen: false);
    await provider.getAllCategoryProducts(widget.categoryId);
  }

  List<ProductCategory> getFilteredProducts(
      List<ProductCategory> products, String query) {
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
        child: FutureBuilder(
          future: _fetchProductsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingCategoryItem();
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  S.of(context).errorConnection,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: tdGrey,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return _buildContent(context);
            }
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final provider = Provider.of<ProductsProvider>(context);
    var categoryProducts = provider.categoryProduct;
    var filteredProducts = getFilteredProducts(categoryProducts, searchQuery);
    return SingleChildScrollView(
      child: Column(
        children: [
          ItemCategoriesHead(title: widget.title),
          SizedBox(height: 5.h),
          ItemSearchBar(
            controller: searchController,
            onSearch: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
          SizedBox(height: 20.h),
          if (filteredProducts.isEmpty)
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Center(
                child: Text(
                 S.of(context).noProductFound,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: tdGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          if (filteredProducts.isNotEmpty)
            ..._buildProductRows(filteredProducts),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }

  List<Widget> _buildProductRows(List<ProductCategory> products) {
    List<Widget> rows = [];
    for (int i = 0; i < products.length; i += 2) {
      Widget row = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(5.w),
            child: CartItemView(
              title: products[i].productName,
              mainPrice: products[i].price,
              salePrice: products[i].discountedPrice,
              image: '${ApiEndpoints.localBaseUrl}/${products[i].productImage}',
              markNo: products[i].mark!.markNo,
              colorNo: products[i].color!.colorNo,
              productNo: products[i].productNo,
              colorName: products[i].color!.colorName,
              markName: products[i].mark!.markName,
            ),
          ),
          if (i + 1 < products.length)
            Padding(
              padding: EdgeInsets.all(5.w),
              child: CartItemView(
                title: products[i + 1].productName,
                mainPrice: products[i + 1].price,
                salePrice: products[i + 1].discountedPrice,
                image:
                    '${ApiEndpoints.localBaseUrl}/${products[i + 1].productImage}',
                markNo: products[i + 1].mark!.markNo,
                colorNo: products[i + 1].color!.colorNo,
                productNo: products[i + 1].productNo,
                colorName: products[i + 1].color!.colorName,
                markName: products[i + 1].mark!.markName,
              ),
            ),
        ],
      );
      rows.add(Padding(padding: EdgeInsets.all(2.w), child: row));
    }
    return rows;
  }
}

