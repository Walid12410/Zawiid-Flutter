import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../Color&Icons/color.dart';
import '../../provider/Products_Provider.dart';

class ItemPrice extends StatelessWidget {
  const ItemPrice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProductsProvider productProvider =
        Provider.of<ProductsProvider>(context, listen: true);
    var product = productProvider.productById;

    String price =
        product.isNotEmpty && product[0].price != null ? product[0].price : '';
    String discountedPrice =
        product.isNotEmpty && product[0].discountedPrice != null
            ? product[0].discountedPrice
            : '';

    if (discountedPrice == "" ||
        discountedPrice == ".00" ||
        discountedPrice == "0" ||
        discountedPrice == "0.00" ||
        discountedPrice == "0.0" ||
        discountedPrice == null) {
      return Row(
        children: [
          Text(
            price,
            style: TextStyle(
              fontSize: 20.sp,
              color: tdBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Text(
            price,
            style: TextStyle(
              fontSize: 14.sp,
              color: tdBlack,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.lineThrough,
              decorationThickness:
                  2.5,
              decorationColor: tdGrey,
            ),
          ),
          SizedBox(width: 15.w),
          Text(
            discountedPrice,
            style: TextStyle(
                fontSize: 20.sp,
                color: Colors.red,
                fontWeight: FontWeight.bold),
          )
        ],
      );
    }
  }
}
