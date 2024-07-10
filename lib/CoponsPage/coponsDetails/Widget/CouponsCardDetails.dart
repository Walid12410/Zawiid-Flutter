import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import '../../../Color&Icons/color.dart';
import '../../../provider/Coupons_Provider.dart';
import '../../../provider/SelectionMarkColor_Provider.dart';

class CouponsCardDetails extends StatelessWidget {
  const CouponsCardDetails({Key? key});

  @override
  Widget build(BuildContext context) {
    CouponsProvider couponsProvider = Provider.of<CouponsProvider>(context, listen: true);
    var couponList = couponsProvider.couponsMark;
    MarkColorProvider markProvider = Provider.of<MarkColorProvider>(context, listen: true);
    var markDetails = markProvider.oneMarkByIDCoupons;

    List<Widget> rows = [];

    DateTime now = DateTime.now();
    var validCoupons = couponList.where((coupon) => coupon.expiryDate.isAfter(now)).toList();


    if (validCoupons.isEmpty || couponList.isEmpty) {
      rows.add(
        Padding(
          padding: const EdgeInsets.all(8.0).w,
          child: Center(
            child: Text(
              'No coupons added yet.',
              style: TextStyle(
                fontSize: 12.sp,
                color: tdGrey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    } else {
      for (var coupon in couponList) {
        DateTime expiryDate = coupon.expiryDate;
        if (expiryDate.isBefore(now)) {
          continue;
        }

        int daysLeft = expiryDate.difference(now).inDays;

        rows.add(
          Padding(
            padding: const EdgeInsets.all(4).w,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5).w,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(-16214415)),
                      borderRadius: BorderRadius.circular(5.w),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5).w,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 2.sp,
                          ),
                          Text(
                            '${coupon.savings} %',
                            style: TextStyle(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(-16214415),
                            ),
                          ),
                          Text(
                            'OFF',
                            style: TextStyle(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(-16214415),
                            ),
                          ),
                          SizedBox(
                            height: 5.sp,
                          ),
                          Container(
                            width: 35.w,
                            color: const Color(-16214415),
                            child: Center(
                              child: Text(
                                'Deal',
                                style: TextStyle(
                                  color: tdWhite,
                                  fontSize: 8.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.sp,
                ),
                SizedBox(
                  width: 180.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8).w,
                        child: Text(
                          '${markDetails[0].markName ?? ""} Member Offer: Up to ${coupon.savings}% off for Member Only ',
                          style: TextStyle(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.bold,
                            color: tdBlack,
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          Container(
                            width: 80.w,
                            color: tdGold,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                      left: 5, right: 5, bottom: 2, top: 2)
                                  .w,
                              child: Center(
                                child: Text(
                                  '${markDetails[0].markName ?? ""} MEMBER',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: tdWhite,
                                    fontSize: 8.sp,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            'Expires in $daysLeft days',
                            style: TextStyle(
                              fontSize: 8.sp,
                              color: tdGrey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      ReadMoreText(
                        coupon.couponDesc,
                        trimMode: TrimMode.Length,
                        trimLength: 62,
                        style: TextStyle(fontSize: 8.sp, color: tdGrey),
                        colorClickableText: tdBlue,
                        trimCollapsedText: 'More',
                        trimExpandedText: 'Less',
                        moreStyle: TextStyle(
                          fontSize: 8.sp,
                          color: tdBlue,
                          fontWeight: FontWeight.bold,
                        ),
                        lessStyle: TextStyle(
                          fontSize: 8.sp,
                          color: tdBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.push(context.namedLocation('CouponsPromotion',
                              pathParameters: {
                                'couponsId': coupon.couponNo.toString(),
                              }));
                        },
                        child: Container(
                          width: double.infinity,
                          color: const Color(-9305855),
                          child: Padding(
                            padding: const EdgeInsets.all(8).w,
                            child: Center(
                              child: Text(
                                'SHOW COUPON',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: tdWhite,
                                  fontSize: 8.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.wifi,
                                size: 10.w,
                                color: tdGrey,
                              ),
                              Text(
                                'People Used',
                                style: TextStyle(
                                  fontSize: 8.sp,
                                  color: tdGrey,
                                ),
                              ),
                            ],
                          ),
                          const Row(
                            children: [
                              SizedBox(),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.share,
                                size: 10.w,
                                color: tdGrey,
                              ),
                              Text(
                                'Share',
                                style: TextStyle(
                                  color: tdBlue,
                                  fontSize: 8.sp,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.email,
                                size: 10.w,
                                color: tdGrey,
                              ),
                              Text(
                                'Email',
                                style: TextStyle(
                                  color: tdBlue,
                                  fontSize: 8.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }

    return Column(
      children: rows,
    );
  }
}
