import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:zawiid/provider/Products_Provider.dart';
import 'package:zawiid/Widget/SubCatProductCartHome.dart';


class TopSubCategoryProduct extends StatefulWidget {
  const TopSubCategoryProduct({super.key,required this.subCatID});

  final int subCatID;
  @override
  State<TopSubCategoryProduct> createState() => _TopSubCategoryProductState();
}

class _TopSubCategoryProductState extends State<TopSubCategoryProduct> {
  late Future<void> _fetchProductsFuture;

  @override
  void initState() {
    super.initState();
    _fetchProductsFuture = _fetchProducts(widget.subCatID);
  }

  @override
  void didUpdateWidget(covariant TopSubCategoryProduct oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.subCatID != widget.subCatID) {
      setState(() {
        _fetchProductsFuture = _fetchProducts(widget.subCatID);
      });
    }
  }

  Future<void> _fetchProducts(int subCategoryId) async {
    final provider = Provider.of<ProductsProvider>(context, listen: false);
    await provider.getTopSubCategoryProduct(subCategoryId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchProductsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: tdBlack,)
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
              var categoryProducts = provider.topSubCategoryProducts;

              if (categoryProducts.isEmpty ||
                  widget.subCatID!= categoryProducts[0].subCarNo) {
                return Center(
                  child: Text(
                    S.of(context).noProductFound,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: tdGrey,
                    ),
                  ),
                );
              }

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
                    return SubCategoryProductCard(product: categoryProducts[productIndex]);
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

