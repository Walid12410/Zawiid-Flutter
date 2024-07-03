import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../Color&Icons/color.dart';
import '../../provider/Bid_Provider.dart';
import '../../provider/Products_Provider.dart';
import '../../provider/SelectionMarkColor_Provider.dart';
import '../WatchDown/WatchCount2.dart';

class BidPageDetails extends StatelessWidget {
  const BidPageDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProductsProvider productById = Provider.of<ProductsProvider>(context, listen: true);
    MarkColorProvider colorById = Provider.of<MarkColorProvider>(context, listen: true);
    BidProvider bidProvider = Provider.of<BidProvider>(context, listen: true);
    var bid = bidProvider.bidById;
    var color = colorById.oneColorByIDBid;
    var product = productById.productById;
    var latestBid = bidProvider.latestBid;

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
                '${latestBid.isNotEmpty? latestBid[0].zawidAmt : bid[0].startPrice} KD',
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
          Center(
            child: Container(
              height: 30.h,
              width: 250.w,
              decoration: BoxDecoration(
                color: tdBlack,
                borderRadius: BorderRadius.circular(50).w,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 160.w,
                    decoration: BoxDecoration(
                      color: tdWhite,
                      borderRadius: BorderRadius.circular(50).w,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5).w,
                        child: TextField(
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d{0,9}(\.\d{0,4})?$')),
                          ],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Bid Price',
                            hintStyle: TextStyle(fontSize: 10.sp, color: tdGrey),
                          ),
                          style: TextStyle(fontSize: 10.sp, color: tdBlack),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 80.w,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ).w,
                      color: tdBlack,
                    ),
                    child: Center(
                      child: Text(
                        'Bid Now',
                        style: TextStyle(fontSize: 8.sp, color: tdWhite),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
