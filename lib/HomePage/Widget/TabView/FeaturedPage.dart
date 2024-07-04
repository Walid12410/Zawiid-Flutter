import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Classes/Featured/Featured.dart';
import '../../../ApiEndPoint.dart';
import '../../../Color&Icons/color.dart';
import '../../../provider/Products_Provider.dart';
import '../TabCard.dart';

class FeaturedPageView extends StatelessWidget {
  const FeaturedPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    ProductsProvider productProvider =
        Provider.of<ProductsProvider>(context, listen: true);
    List<Featured> featuredProducts = productProvider.featuredProduct;

    if (featuredProducts.isEmpty) {
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
    }

    List<Featured> activeFeaturedProducts = featuredProducts.where((featured) {
      DateTime endDate = featured.endDate;
      return endDate.isAfter(now) || endDate.isAtSameMomentAs(now);
    }).toList();

    List<Widget> rows = [];

    for (int i = 0; i < activeFeaturedProducts.take(4).length; i += 2) {
      List<Widget> cards = [];

      for (int j = 0; j < 2; j++) {
        if (i + j < activeFeaturedProducts.take(4).length) {
          var products = activeFeaturedProducts[i + j].products;

          cards.add(
            Expanded(
              child: TabCard(
                productNo: products![0].productNo,
                productName: products[0].productName,
                productDesc: products[0].productDesc,
                productImage:
                    '${ApiEndpoints.localBaseUrl}/${products[0].productImage}',
                productPrice: products[0].price,
                markNo: products[0].markNo,
                colorNo: products[0].colorNo,
                productSalePrice: products[0].discountedPrice,
              ),
            ),
          );
        } else {
          cards.add(
            Expanded(
              child: Container(),
            ),
          );
        }
      }

      rows.add(
        Row(
          children: cards,
        ),
      );
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: rows.length,
      itemBuilder: (context, index) {
        return rows[index];
      },
    );
  }
}
