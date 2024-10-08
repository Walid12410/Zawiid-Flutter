import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import '../../../Skeleton/Skeleton.dart';

class LoadingContainerCouponsPromotion extends StatelessWidget {
  const LoadingContainerCouponsPromotion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Skeleton(width: 200.w,height: 40.h,),
                    Skeleton(width: 120.w,height: 40.h,),
                  ],
                ),
                SizedBox(height: 10.h,),

                Skeleton(width: double.infinity,height: 40.h,),
                SizedBox(height: 15.h,),
                Skeleton(width: double.infinity,height: 50.h,),
                SizedBox(height: 10.h,),
                Skeleton(width: 100.w,height: 20.h,),
                SizedBox(height: 10.h,),
                Skeleton(width: double.infinity,height: 180.h,),
                SizedBox(height: 5.h,),
                Skeleton(width: 120,height: 20.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
