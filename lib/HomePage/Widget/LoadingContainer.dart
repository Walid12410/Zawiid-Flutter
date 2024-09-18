import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Skeleton/Skeleton.dart';


class LoadingContainer extends StatelessWidget {
  const LoadingContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.h),
          Center(
            child: Skeleton(height: 40.h,width: 60.w,),
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
          SizedBox(height: 5.h,),
          Skeleton(height: 200.h,width: double.infinity,),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton(height: 100.h,width: 240.h,),
              Skeleton(height: 100.h,width: 40.w,),
            ],
          ),
          SizedBox(height: 5.h),
          Skeleton(height: 1.h,width: double.infinity,),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Skeleton(height: 25.h,width: 70.w,),
              Skeleton(height: 25.h,width: 70.w,),
              Skeleton(height: 25.h,width: 70.w,)
            ],
          ),
          SizedBox(height: 10.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Skeleton(height: 200.h,width: 160.w,),
              Skeleton(height: 200.h,width: 160.w,),
            ],
          )

        ],
      ),
    );
  }
}
