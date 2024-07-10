import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/ApiEndPoint.dart';
import '../../../Color&Icons/color.dart';
import '../../../provider/SelectionMarkColor_Provider.dart';

class TitleAndDescription extends StatelessWidget {
  const TitleAndDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MarkColorProvider markProvider = Provider.of<MarkColorProvider>(context, listen: true);
    var markDetails = markProvider.oneMarkByIDCoupons;


    if (markDetails.isEmpty ) {
      return const Center(
          child: CircularProgressIndicator(
        color: tdBlack,
      ));
    }

    String markImage = '${ApiEndpoints.localBaseUrl}/${markDetails[0].markImage}';

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
                ' Coupon & Promo Codes',
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
          Text(
            markDetails[0].markDesc,
            style: TextStyle(fontSize: 8.sp, color: tdBlack),
          ),
        ],
      ),
    );
  }
}
