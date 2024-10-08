import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/provider/Products_Provider.dart';
import 'package:zawiid/provider/SelectionMarkColor_Provider.dart';

class ItemTitle extends StatelessWidget {
  const ItemTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProductsProvider productProvider = Provider.of<ProductsProvider>(context, listen: true);
    MarkColorProvider colorMarkProvider = Provider.of<MarkColorProvider>(context, listen: true);
    var product = productProvider.productById;
    var color = colorMarkProvider.oneColorByID;
    var mark = colorMarkProvider.oneMarkByID;

    String markName = mark.isNotEmpty && mark[0].markName != null ? mark[0].markName : '';
    String productNameDesc =
        product.isNotEmpty && product[0].productName != ""
            ? '${product[0].productName} ${product[0].productDesc} '
            : '';
    String colorName = color.isNotEmpty && color[0].colorName != ""
        ? color[0].colorName
        : '';

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          markName,
          style: TextStyle(
              fontSize: 17.sp, fontWeight: FontWeight.bold, color: tdBlack),
        ),
        SizedBox(height: 2.h),
        Text(
          productNameDesc,
          style: TextStyle(color: tdBlack, fontSize: 12.sp),
        ),
        Text(
          colorName,
          style: TextStyle(fontSize: 12.sp, color: tdBlack),
        ),
      ],
    );
  }
}
