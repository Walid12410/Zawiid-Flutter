import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Widget/TabCardProduct.dart';
import 'package:zawiid/core/config.dart';
import '../../../../provider/Products_Provider.dart';
import '../../../../Widget/TabCardFeatured.dart';

class OnSalePageView extends StatelessWidget {
  const OnSalePageView({super.key});

  @override
  Widget build(BuildContext context) {
    ProductsProvider provider =
        Provider.of<ProductsProvider>(context, listen: true);
    var onSaleProduct = provider.productOnSale;

    if (onSaleProduct.isEmpty) {
      return Center(
        child:  SizedBox(
          width: 90.w,
          height: 100.h,
          child: Image.asset(
            'assets/log/LOGO-icon---Black.png',
            fit: BoxFit.contain,
          ),
        ),
      );
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount:
          (onSaleProduct.length > 4) ? 2 : (onSaleProduct.length / 2).ceil(),
      itemBuilder: (context, rowIndex) {
        int startIndex = rowIndex * 2;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(2, (index) {
            int productIndex = startIndex + index;
            if (productIndex < onSaleProduct.length) {
              return TabCardProduct(product: onSaleProduct[productIndex]);
            } else {
              return const SizedBox();
            }
          }).toList(),
        );
      },
    );
  }
}
