import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Skeleton/Skeleton.dart';


class LoadingContainerItem extends StatelessWidget {
  const LoadingContainerItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10).w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10).w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Skeleton(width: 40.h,height: 25.h,),
                  Skeleton(width: 40.h,height: 25.h,)
                ],
              ),
            ),
            SizedBox(height: 10.h,),
            Skeleton(height: 300.h,width: double.infinity,),
            SizedBox(height: 10.h,),
            Skeleton(height: 10.h,width: 90.w,),
            SizedBox(height: 5.h,),
            Skeleton(height: 30.h,width: 200.w,),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Skeleton(height: 20.h,width: 120.w,),
                SizedBox(width: 10.w,),
                Skeleton(height: 30.h,width: 100.w,),
              ],
            ),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Skeleton(height: 30.h,width: 200.w,),
                SizedBox(width: 10.w,),
                Skeleton(height: 30.h,width: 100.w,),
              ],
            ),
            SizedBox(height: 10.h,),
            Skeleton(height: 20.h,width: 70.w,),
            SizedBox(height: 10.h,),
            Skeleton(width: double.infinity,height: 200.h,),
          ],
        ),
      ),
    );
  }
}
