import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Color&Icons/color.dart';
import '../WatchDown/WatchCount2.dart';
import 'BidPageBottom.dart';


class BidPageDetails extends StatelessWidget {
  const BidPageDetails({
    super.key,
    required this.endTime,
  });

  final DateTime endTime;

  @override
  Widget build(BuildContext context) {
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
            'iPhone 14 Pro Max 256gb - Black Titanium',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: tdGrey,
                fontSize: 12.sp),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'The iPhone 14 Pro Max comes with 6.7-inch OLED display with 120Hz refresh rate and Apple’s improved Bionic A16 processor. On the back there is a Triple camera setup with 48MP main camera',
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
          SizedBox(height: 20.h,),
          const BidPageBottom(),
          SizedBox(height: 5.h,),
          CountdownTimerScreen2(endTime: endTime,)
        ],
      ),
    );
  }
}
