import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/core/config.dart';
import '../../../../provider/Products_Provider.dart';
import '../TabCard.dart';

class TopRatedPageView extends StatelessWidget {
  const TopRatedPageView({super.key});

  @override
  Widget build(BuildContext context) {
    ProductsProvider provider = Provider.of<ProductsProvider>(context, listen: true);
    var productTopRated = provider.productTopRated;

    if (productTopRated.isEmpty) {
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
      itemCount: (productTopRated.length > 4)
          ? 2
          : (productTopRated.length / 2).ceil(),
      itemBuilder: (context, rowIndex) {
        int startIndex = rowIndex * 2;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(2, (index) {
            int productIndex = startIndex + index;
            if (productIndex < productTopRated.length) {
              return TabCard(
                productNo: productTopRated[productIndex].productNo,
                productName: productTopRated[productIndex].productName,
                productDesc: productTopRated[productIndex].productDesc,
                productImage:
                    '${ApiEndpoints.localBaseUrl}/${productTopRated[productIndex].productImage}',
                productPrice: productTopRated[productIndex].price,
                markNo: productTopRated[productIndex].markNo,
                colorNo: productTopRated[productIndex].colorNo,
                productSalePrice: productTopRated[productIndex].discountedPrice,
              );
            } else {
              return const SizedBox();
            }
          }).toList(),
        );
      },
    );
  }
}
