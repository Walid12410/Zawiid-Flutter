import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../ApiEndPoint.dart';
import '../../../Color&Icons/color.dart';
import '../../../provider/Coupons_Provider.dart';
import '../../../provider/SelectionMarkColor_Provider.dart';
import 'CouponsPromotionTable.dart';

class CouponsPromotionDetails extends StatelessWidget {
  const CouponsPromotionDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MarkColorProvider markProvider = Provider.of<MarkColorProvider>(context, listen: true);
    var markDetails = markProvider.oneMarkByIDCoupons;
    CouponsProvider couponsProvider = Provider.of<CouponsProvider>(context, listen: true);
    var couponsDetails = couponsProvider.oneCoupon;
    var couponsDetailsTable = couponsProvider.couponsDetailsByCouponNo;

    String markImage = '${ApiEndpoints.localBaseUrl}/${markDetails[0].markImage}';
    String formattedStartTime = DateFormat('MMMM yyyy').format(couponsDetails[0].issueDate);

    String formattedEndTime = DateFormat('dd MMMM yyyy').format(couponsDetailsTable[0].expiryDate);

    if(markDetails.isEmpty || couponsDetails.isEmpty || couponsDetailsTable.isEmpty){
      return const Center(
        child: CircularProgressIndicator(color: tdBlack,),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(10).w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            height: 80.h,
            child: CachedNetworkImage(
              imageUrl: markImage,
              placeholder: (context, url) =>
                  Image.asset('assets/log/LOGO-icon---Black.png'),
              errorWidget: (context, url, error) =>
                  Image.asset('assets/log/LOGO-icon---Black.png'),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              Text(
                markDetails[0].markName,
                style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: tdBlack),
              ),
              Text(
                ' Coupon & Promo Codes - $formattedStartTime',
                style: TextStyle(fontSize: 11.sp, color: tdGrey),
              ),
            ],
          ),
          Text(
            'adidas.com.kw',
            style: TextStyle(
                fontSize: 5.sp, color: tdBlue, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 200.w,
                height: 45.h,
                decoration: BoxDecoration(
                    border: Border.all(color: tdBlack),
                    borderRadius: BorderRadius.circular(15).w),
                child: Center(
                  child: Text(
                    couponsDetailsTable[0].code,
                    style: TextStyle(
                        fontSize: 27.sp,
                        fontWeight: FontWeight.bold,
                        color: tdBlack),
                  ),
                ),
              ),
              const SizedBox(),
              Container(
                width: 130.w,
                height: 45.h,
                decoration: BoxDecoration(
                    border: Border.all(color: tdBlack),
                    borderRadius: BorderRadius.circular(15).w,
                    color: tdBlack),
                child: Center(
                  child: Text(
                    'COPY',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: tdWhite),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            onTap: () {
              GoRouter.of(context).go('/home');
            },
            child: Container(
              width: double.infinity,
              height: 45.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15).w,
                  border: Border.all(color: tdBlack)),
              child: Center(
                child: Text(
                  'GO TO THE STORE',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: tdBlack,
                      fontSize: 12.sp),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0).w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shop your favorite Adidas wearables in Kuwait and get a guaranteed, huge discount! Just use the Adidas coupon code and get a flat 20% discount on the entire stock!',
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: tdBlack,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  '${markDetails[0].markName} Discount Code:',
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: tdBlack,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.h,
                ),
                const CouponsTable(),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Expires in $formattedEndTime',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: tdBlack),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
