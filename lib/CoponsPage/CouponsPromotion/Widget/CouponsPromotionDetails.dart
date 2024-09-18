import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/generated/l10n.dart';
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
    var couponsDetailsTable = couponsProvider.oneCoupon;

    String markImage = '${ApiEndpoints.localBaseUrl}/${markDetails[0].markImage}';
    String formattedStartTime = DateFormat('MMMM yyyy').format(couponsDetails[0].issueDate);

    String formattedEndTime = DateFormat('dd MMMM yyyy').format(couponsDetailsTable[0].expiryDate);

    if(markDetails.isEmpty || couponsDetails.isEmpty || couponsDetailsTable.isEmpty){
      return const Center(
        child: CircularProgressIndicator(color: tdBlack,),
      );
    }

    void copyToClipboard(String text) {
      Clipboard.setData(ClipboardData(text: text));
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text(S.of(context).couponCodeCopied,style: TextStyle(fontSize: 10.sp,color: tdWhite),),
          duration: const Duration(seconds: 2),
          backgroundColor: tdBlack,
        ),
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
                ' ${S.of(context).couponAndPromoCodes} - $formattedStartTime',
                style: TextStyle(fontSize: 11.sp, color: tdGrey),
              ),
            ],
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
                        color: tdBlack),overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(),
              GestureDetector(
                onTap: (){
                  copyToClipboard(couponsDetailsTable[0].code);
                },
                child: Container(
                  width: 130.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: tdBlack),
                      borderRadius: BorderRadius.circular(15).w,
                      color: tdBlack),
                  child: Center(
                    child: Text(
                      S.of(context).copy,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: tdWhite),
                    ),
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
                  S.of(context).goToTheStore,
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
                  couponsDetailsTable[0].couponDesc,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: tdBlack,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  '${markDetails[0].markName} ${S.of(context).discountCode}',
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
                  '${S.of(context).expiresIn} $formattedEndTime',
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
