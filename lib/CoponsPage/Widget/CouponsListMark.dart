import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Color&Icons/color.dart';

import '../../ApiEndPoint.dart';
import '../../provider/Coupons_Provider.dart';
import 'CouponsCard.dart';

class CouponsListView extends StatelessWidget {
  const CouponsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final couponsProvider = Provider.of<CouponsProvider>(context);
    final allCoupons = couponsProvider.couponsOfMark;

    final now = DateTime.now();

    final validCoupons = allCoupons.where((coupon) {
      final issueDate = DateTime.parse(coupon.issueDate.toString());
      final expiryDate = DateTime.parse(coupon.expiryDate.toString());
      return now.isAfter(issueDate) && now.isBefore(expiryDate);
    }).toList();

    final displayedMarks = <int>{};
    final uniqueCoupons = validCoupons.where((coupon) {
      if (displayedMarks.contains(coupon.markNo)) {
        return false;
      } else {
        displayedMarks.add(coupon.markNo);
        return true;
      }
    }).toList();

    if (uniqueCoupons.isEmpty) {
      return Column(
        children: [
          SizedBox(
            height: 150.h,
          ),
          Center(
              child: Text(
            'No coupons added yet.',
            style: TextStyle(
                fontSize: 15.sp, color: tdGrey, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ))
        ],
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: uniqueCoupons.length,
      itemBuilder: (context, index) {
        var coupon = uniqueCoupons[index];
        var markImage = coupon.mark.markImage;
        return CouponCard(
          couponsId: coupon.couponNo,
          couponsImage: '${ApiEndpoints.localBaseUrl}/$markImage',
          markNo: coupon.markNo,
          issueDate: coupon.issueDate,
          expiryDate: coupon.expiryDate,
        );
      },
    );
  }
}
