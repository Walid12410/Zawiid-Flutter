import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import '../../Skeleton/Skeleton.dart';


class LoadingContainerCoupons extends StatelessWidget {
  const LoadingContainerCoupons({
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
              children: [
                SizedBox(height: 15.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Skeleton(width: 40.w,height: 25.h,),
                    Skeleton(width: 70.w,height: 25.h,), SizedBox(width: 5.h,)
                  ],),
                SizedBox(height: 20.h,),
                Skeleton(height: 150.h,width: double.infinity,),
                SizedBox(height: 5.h,),
                Skeleton(height: 150.h,width: double.infinity,),
                SizedBox(height: 5.h,),
                Skeleton(height: 150.h,width: double.infinity,),
                SizedBox(height: 5.h,),
                Skeleton(height: 150.h,width: double.infinity,),
                SizedBox(height: 5.h,),
                Skeleton(height: 150.h,width: double.infinity,)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
