import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Color&Icons/color.dart';

class SoldDetails extends StatelessWidget {
  const SoldDetails({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).w,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 210.h,
            child: Image.asset(
              'assets/img/iphone.png',
              fit: BoxFit.contain,
            ),
          ),
          Text(
            'iPhone 14 ProMax / 256GB Black Color',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                color: tdBlack),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            '30th April. 10.00PM',
            style: TextStyle(fontSize: 8.sp, color: tdGrey),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            'SOLD AT: 1550KD',
            style: TextStyle(fontSize: 8.sp, color: tdGrey),
          ),
          SizedBox(height: 10.h),
          Container(
            width: 180.w,
            height: 20.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20).w,
                border: Border.all(color: tdBlack)),
            child: Center(
              child: Text(
                'SOLD',
                style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: tdBlack),
              ),
            ),
          ),
          SizedBox(height: 2.h,),
        ],
      ),
    );
  }
}
