import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Widget/Card/TabCardFeatured.dart';
import 'package:zawiid/model/Featured/Featured.dart';
import '../../../../provider/Products_Provider.dart';

class FeaturedPageView extends StatelessWidget {
  const FeaturedPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    ProductsProvider productProvider =
    Provider.of<ProductsProvider>(context, listen: true);
    List<FeaturedProduct> featuredProducts = productProvider.featuredProduct;

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

    List<FeaturedProduct> activeFeaturedProducts = featuredProducts.where((featured) {
      DateTime startDate = featured.startDate;
      DateTime endDate = featured.endDate;
      return (now.isAfter(startDate) || now.isAtSameMomentAs(startDate)) &&
          (now.isBefore(endDate) || now.isAtSameMomentAs(endDate));
    }).toList();

    List<Widget> rows = [];

    for (int i = 0; i < activeFeaturedProducts.take(4).length; i += 2) {
      List<Widget> cards = [];

      for (int j = 0; j < 2; j++) {
        if (i + j < activeFeaturedProducts.take(4).length) {
          var product = activeFeaturedProducts[i + j];

          cards.add(
            Expanded(
              child: TabCardFeatured(product: product),
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
