import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../screen/Skeleton/Skeleton.dart';


class LoadingContainerCouponsDetails extends StatelessWidget {
  const LoadingContainerCouponsDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15).w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Skeleton(width: 40.w,height: 25.h,),
                Skeleton(width: 70.w,height: 25.h,), SizedBox(width: 5.h,)
              ],
            ),
            SizedBox(height: 40.h,),
            Skeleton(height: 30.h,width: 100.w,),
            SizedBox(height: 20.h,),
            Skeleton(width: 120.w,height: 20.h,),
            SizedBox(height: 10.h,),
            Skeleton(width: double.infinity,height: 30.h,),
            SizedBox(height: 10.h,),
            Skeleton(width: double.infinity,height: 500.h,),
          ],
        ),
      ),
    );
  }
}
