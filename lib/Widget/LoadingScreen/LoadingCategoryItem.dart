import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../screen/Skeleton/Skeleton.dart';



class LoadingCategoryItem extends StatelessWidget {
  const LoadingCategoryItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15).w,
        child: Column(
          children: [
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Skeleton(height: 25.h,width: 40.w,),
                Skeleton(height: 25.h,width: 100.w,),
                SizedBox(width: 20.w,),
              ],
            ),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeleton(height: 25.h, width: 25.w),
                Skeleton(height: 25.h,width: 270.w,),
                Skeleton(height: 25.h, width: 25.w),
              ],
            ),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeleton(height: 200.h, width: 155.w),
                Skeleton(height: 200.h,width: 155.w,),
              ],
            ),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeleton(height: 200.h, width: 155.w),
                Skeleton(height: 200.h,width: 155.w,),
              ],
            ),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeleton(height: 200.h, width: 155.w),
                Skeleton(height: 200.h,width: 155.w,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
