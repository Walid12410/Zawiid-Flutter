import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../ApiEndPoint.dart';
import '../../Color&Icons/color.dart';
import '../../provider/Products_Provider.dart';
import 'ProductSubCatCard.dart';

class ProductsOfSubCategoriesHome extends StatefulWidget {
  final int subCategoryId;

  const ProductsOfSubCategoriesHome({Key? key, required this.subCategoryId})
      : super(key: key);

  @override
  _ProductsOfSubCategoriesHomeState createState() =>
      _ProductsOfSubCategoriesHomeState();
}

class _ProductsOfSubCategoriesHomeState extends State<ProductsOfSubCategoriesHome> {
  late Future<void> _fetchProductsFuture;

  @override
  void initState() {
    super.initState();
    _fetchProductsFuture = _fetchProducts(widget.subCategoryId);
  }

  @override
  void didUpdateWidget(covariant ProductsOfSubCategoriesHome oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.subCategoryId != widget.subCategoryId) {
      setState(() {
        _fetchProductsFuture = _fetchProducts(widget.subCategoryId);
      });
    }
  }

  Future<void> _fetchProducts(int subCategoryId) async {
    final provider = Provider.of<ProductsProvider>(context, listen: false);
    await provider.getAllCategoryProductsHome(subCategoryId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Something went wrong, check your connection.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                color: tdGrey,
              ),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return Consumer<ProductsProvider>(
            builder: (context, provider, _) {
              var categoryProducts = provider.categoryProductHome;

              if (categoryProducts.isEmpty ||
                  widget.subCategoryId!= categoryProducts[0].subCategoryNo) {
                return Center(
                  child: Text(
                    'No products added yet',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: tdGrey,
                    ),
                  ),
                );
              }

              categoryProducts = categoryProducts.take(4).toList();
              int rowCount = (categoryProducts.length / 2).ceil();

              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: rowCount,
                itemBuilder: (context, rowIndex) {
                  int startIndex = rowIndex * 2;
                  int endIndex = startIndex + 2;
                  if (endIndex > categoryProducts.length) {
                    endIndex = categoryProducts.length;
                  }

                  List<Widget> rowChildren = List.generate(endIndex - startIndex, (index) {
                    int productIndex = startIndex + index;
                    return ProductSubCategoriesHomePageCard(
                      title: categoryProducts[productIndex].productName,
                      desc: categoryProducts[productIndex].productDesc,
                      mainPrice: categoryProducts[productIndex].price,
                      salePrice: categoryProducts[productIndex].discountedPrice,
                      image: '${ApiEndpoints.localBaseUrl}/${categoryProducts[productIndex].productImage}',
                      productNo: categoryProducts[productIndex].productNo,
                      markNo: categoryProducts[productIndex].mark!.markNo,
                      colorNo: categoryProducts[productIndex].color!.colorNo,
                    );
                  });

                  if (rowChildren.length == 3) {
                    return Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: rowChildren,
                      ),
                    );
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: rowChildren,
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
