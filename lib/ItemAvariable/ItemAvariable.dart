import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:zawiid/provider/Products_Provider.dart';
import '../Classes/Product/Products.dart';
import 'Widget/CartItemView.dart';
import 'Widget/ItemViewHead.dart';
import 'Widget/ItemViewSearchBar.dart';

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

  List<Product> getFilteredProducts(List<Product> products, String query) {
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
              return Center(
                      child: SizedBox(
                        width: 90.w,
                        height: 100.h,
                        child: Image.asset(
                          'assets/log/LOGO-icon---Black.png',
                          fit: BoxFit.contain,
                        ),
                      )
                  );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Something went wrong, check you connection.',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: tdGrey,
                    fontWeight: FontWeight.bold,
                  ),
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
          if (filteredProducts.isEmpty)
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Center(
                child: Text(
                  'No products found',
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

  List<Widget> _buildProductRows(List<Product> products) {
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
              desc: products[i].productDesc,
              mainPrice: products[i].price,
              salePrice: products[i].discountedPrice,
              image: '${ApiEndpoints.localBaseUrl}/${products[i].productImage}',
            ),
          ),
          if (i + 1 < products.length)
            Padding(
              padding: EdgeInsets.all(5.w),
              child: CartItemView(
                title: products[i + 1].productName,
                desc: products[i + 1].productDesc,
                mainPrice: products[i + 1].price,
                salePrice: products[i + 1].discountedPrice,
                image:
                    '${ApiEndpoints.localBaseUrl}/${products[i + 1].productImage}',
              ),
            ),
        ],
      );
      rows.add(Padding(padding: EdgeInsets.all(2.w), child: row));
    }
    return rows;
  }
}
