import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Color&Icons/color.dart';

class ItemShipping extends StatelessWidget {
  const ItemShipping({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Shipping',style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.bold,color: tdBlack),),
        SizedBox(height: 10.h),
        Text('Scheduled delivery (Free)',style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.bold,color: tdBlack),),
        SizedBox(height: 5.h,),
        Text('Free Next-Day delivery',style: TextStyle(fontSize: 12.sp,color: tdBlack),),
        SizedBox(height: 5.h),
        Text('1-Hour Express Delivery Available',style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.bold,color: tdBlack),),
        SizedBox(height: 5.sp),
        Text('Order now and get it within 1 hour',style: TextStyle(fontSize: 12.sp,color: tdBlack),),
        SizedBox(height: 5.sp,),
        Text('3-Hour Express Delivery Available',style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.bold,color: tdBlack),),
      ],
    );
  }
}
