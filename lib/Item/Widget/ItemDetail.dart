import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../Color&Icons/color.dart';
import '../../provider/Products_Provider.dart';

class ItemDetail extends StatelessWidget {
  const ItemDetail({super.key});

  @override
  Widget build(BuildContext context) {
    ProductsProvider productProvider = Provider.of<ProductsProvider>(context, listen: true);
    var productDetails = productProvider.productDetailsById;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Details',
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold, color: tdBlack),
        ),
        SizedBox(height: 18.h),
        if (productDetails.isEmpty)
          Text(
            'No details added yet.',
            style: TextStyle(fontSize: 12.sp, color: tdBlack),
          )
        else
          ...productDetails.map((detail) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(detail.productDetailsDesc, style: TextStyle(fontSize: 12.sp, color: tdBlack)),
                SizedBox(height: 10.h),
              ],
            );
          }).toList(),
      ],
    );
  }
}
