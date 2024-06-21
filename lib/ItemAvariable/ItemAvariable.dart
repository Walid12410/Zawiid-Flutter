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
  const ItemViewCategories({super.key, required this.title, required this.categoryId});

  final String title;
  final int categoryId;
  @override
  State<ItemViewCategories> createState() => _ItemViewCategoriesState();
}

class _ItemViewCategoriesState extends State<ItemViewCategories> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<ProductsProvider>(context, listen: false);
      provider.getAllCategoryProducts(widget.categoryId);
    });
  }

  List<Product> getFilteredProducts(List<Product> products, String query) {
    return products.where((product) =>
    product.productName.toLowerCase().contains(query.toLowerCase()) ||
        product.productDesc.toLowerCase().contains(query.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsProvider>(context, listen: true);
    var categoryProducts = provider.categoryProduct;
    var filteredProducts = getFilteredProducts(categoryProducts, searchQuery);

    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ItemCategoriesHead(title: widget.title),
              SizedBox(
                height: 5.h,
              ),
              ItemSearchBar(
                controller: searchController,
                onSearch: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
              if (filteredProducts.isEmpty ||
                  widget.categoryId != filteredProducts[0].subCategoryNo)
                Padding(
                  padding: const EdgeInsets.all(20.0).w,
                  child: Center(
                    child: Text(
                      'No products found',
                      style: TextStyle(fontSize: 16.sp, color: tdGrey,fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              else
                SizedBox(
                  height: 10.h,
                ),
              SizedBox(
                height: 10.h,
              ),
              if(filteredProducts.isNotEmpty && widget.categoryId == filteredProducts[0].subCategoryNo)
              for (int i = 0; i < filteredProducts.length; i += 2)
                Padding(
                  padding: const EdgeInsets.all(2).w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5).w,
                        child: CartItemView(
                          title: filteredProducts[i].productName,
                          desc: filteredProducts[i].productDesc,
                          mainPrice: filteredProducts[i].price,
                          salePrice: filteredProducts[i].discountedPrice,
                          image: '${ApiEndpoints.localBaseUrl}/${filteredProducts[i].productImage}',
                        ),
                      ),
                      if (i + 1 < filteredProducts.length)
                        Padding(
                          padding: const EdgeInsets.all(5).w,
                          child: CartItemView(
                            title: filteredProducts[i + 1].productName,
                            desc: filteredProducts[i + 1].productDesc,
                            mainPrice: filteredProducts[i + 1].price,
                            salePrice: filteredProducts[i + 1].discountedPrice,
                            image: '${ApiEndpoints.localBaseUrl}/${filteredProducts[i].productImage}',
                          ),
                        ),
                    ],
                  ),
                ),
              SizedBox(height: 5.h)
            ],
          ),
        ),
      ),
    );
  }
}
