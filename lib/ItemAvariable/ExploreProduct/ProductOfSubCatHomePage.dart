import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../ApiEndPoint.dart';
import '../../Color&Icons/color.dart';
import '../../provider/Products_Provider.dart';
import 'ProductSubCatCard.dart';

class ProductsOfSubCategoriesHome extends StatelessWidget {
  final int subCategoryId;

  const ProductsOfSubCategoriesHome({Key? key, required this.subCategoryId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsProvider>(context);
    provider.getAllCategoryProducts(subCategoryId);

    return Consumer<ProductsProvider>(
      builder: (context, provider, _) {
        var categoryProducts = provider.categoryProduct;

        return categoryProducts.isNotEmpty &&
                subCategoryId == categoryProducts[0].subCategoryNo
            ? ListView.builder(
                physics:
                    const NeverScrollableScrollPhysics(), // Disable scrolling in this ListView
                shrinkWrap: true,
                itemCount: (categoryProducts.length > 4)
                    ? 2
                    : (categoryProducts.length / 2).ceil(), // Show up to 2 rows
                itemBuilder: (context, rowIndex) {
                  int startIndex = rowIndex * 2; // Start index for this row
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(2, (index) {
                      int productIndex = startIndex + index;
                      if (productIndex < categoryProducts.length) {
                        return ProductSubCategoriesHomePageCard(
                          title: categoryProducts[productIndex].productName,
                          desc: categoryProducts[productIndex].productDesc,
                          mainPrice: categoryProducts[productIndex].price,
                          salePrice:
                              categoryProducts[productIndex].discountedPrice,
                          image:
                              '${ApiEndpoints.localBaseUrl}/${categoryProducts[productIndex].productImage}',
                        );
                      } else {
                        return const SizedBox(); // Empty SizedBox if no product at this index
                      }
                    }).toList(),
                  );
                },
              )
            : Center(
                child: Text(
                  'No products added yet.',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    color: tdGrey,
                  ),
                ),
              );
      },
    );
  }
}
