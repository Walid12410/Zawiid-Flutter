import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ApiEndPoint.dart';
import '../../provider/Coupons_Provider.dart';
import 'CouponsCard.dart';

class CouponsListView extends StatelessWidget {
  const CouponsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final couponsProvider = Provider.of<CouponsProvider>(context);
    final allCoupons = couponsProvider.couponsOfMark;
    final displayedMarks = <int>{};
    final uniqueCoupons = allCoupons.where((coupon) {
      if (displayedMarks.contains(coupon.markNo)) {
        return false;
      } else {
        displayedMarks.add(coupon.markNo);
        return true;
      }
    }).toList();

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
