import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../screen/Skeleton/Skeleton.dart';


class LoadingContainerUpcoming extends StatelessWidget {
  const LoadingContainerUpcoming({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15).w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 29.h,),
            Skeleton(height: 150.h,width: 250.w,),
            SizedBox(height: 15.h,),
            Skeleton(height: 20.h,width: 250.w,),
            SizedBox(height: 5.h,),
            Skeleton(height: 10.h,width: 150.w,),
            SizedBox(height: 2.h,),
            Skeleton(height: 10.h,width: 120.w,),
            SizedBox(height: 5.h,),
            Skeleton(height: 30.h,width: 200.w,),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Skeleton(width: 30.w,height: 20.h,),
                SizedBox(width: 5.h,),
                Skeleton(width: 30.w,height: 20.h,),
                SizedBox(width: 5.h,),
                Skeleton(width: 30.w,height: 20.h,),
                SizedBox(width: 5.h,),
                Skeleton(width: 30.w,height: 20.h,),
              ],
            ),
            SizedBox(height: 29.h,),
            Skeleton(height: 150.h,width: 250.w,),
            SizedBox(height: 15.h,),
            Skeleton(height: 20.h,width: 250.w,),
            SizedBox(height: 5.h,),
            Skeleton(height: 10.h,width: 150.w,),
            SizedBox(height: 2.h,),
            Skeleton(height: 10.h,width: 120.w,),
            SizedBox(height: 5.h,),
            Skeleton(height: 30.h,width: 200.w,),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Skeleton(width: 30.w,height: 20.h,),
                SizedBox(width: 5.h,),
                Skeleton(width: 30.w,height: 20.h,),
                SizedBox(width: 5.h,),
                Skeleton(width: 30.w,height: 20.h,),
                SizedBox(width: 5.h,),
                Skeleton(width: 30.w,height: 20.h,),
              ],
            )
          ],
        ),
      ),
    );
  }
}
