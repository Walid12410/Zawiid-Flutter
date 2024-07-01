import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../Color&Icons/color.dart';
import '../../provider/Bid_Provider.dart';
import '../../provider/Products_Provider.dart';
import '../../provider/SelectionMarkColor_Provider.dart';
import '../WatchDown/WatchCount2.dart';
import 'BidPageBottom.dart';

class BidPageDetails extends StatelessWidget {
  const BidPageDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProductsProvider productById = Provider.of<ProductsProvider>(context, listen: true);
    var product = productById.productById;
    MarkColorProvider colorById = Provider.of<MarkColorProvider>(context, listen: true);
    var color = colorById.oneColorByID;
    BidProvider bidProvider = Provider.of<BidProvider>(context, listen: true);
    var bid = bidProvider.bidById;

    if (product.isEmpty || color.isEmpty || bid.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          color: tdBlack,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15).w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15.h,
          ),
          Text(
            '${product[0].productName} - ${color[0].colorName}',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: tdGrey, fontSize: 12.sp),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            product[0].productDesc,
            style: TextStyle(fontSize: 8.sp, color: tdGrey),
          ),
          SizedBox(height: 30.h),
          Padding(
            padding: const EdgeInsets.only(right: 6).w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Current Bid',
                  style: TextStyle(fontSize: 12.sp, color: tdGrey),
                ),
                Text(
                  'Your Last Bid',
                  style: TextStyle(fontSize: 12.sp, color: tdGrey),
                )
              ],
            ),
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$100',
                style: TextStyle(
                    fontSize: 14.sp,
                    color: tdBlack,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '\$100',
                style: TextStyle(fontSize: 14.sp, color: tdGrey),
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          const BidPageBottom(),
          SizedBox(
            height: 5.h,
          ),
          CountdownTimerScreen2(
            endTime: bid[0].bidEndDate,
          )
        ],
      ),
    );
  }
}
