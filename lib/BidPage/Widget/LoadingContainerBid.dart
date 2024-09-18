import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Skeleton/Skeleton.dart';

class LoadingContainerBid extends StatelessWidget {
  const LoadingContainerBid({
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
          Padding(
            padding: const EdgeInsets.all(8.0).w,
            child: Skeleton(height: 230.h,width: double.infinity,),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10).w,
                child: Skeleton(width: 120.w,height: 20.h,),
              ),
              SizedBox(height: 10.h,),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10).w,
                child: Skeleton(width: 100.w,height: 10.h,),
              ),
              SizedBox(height: 30.h,),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15).w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Skeleton(width: 80.w,height: 20.h,),
                    Skeleton(width: 80.w,height: 20.h,),
                  ],
                ),
              ),
              SizedBox(height: 10.h,),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15).w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Skeleton(width: 50.w,height: 20.h,),
                    Skeleton(width: 50.w,height: 20.h,),
                  ],
                ),
              ),
              SizedBox(height: 20.h,),
              Center(child: Skeleton(width: 200.h,height: 40.h,)),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Skeleton(width: 50.w,height: 30.h,),
                  SizedBox(width: 5.h,),
                  Skeleton(width: 50.w,height: 30.h,),
                  SizedBox(width: 5.h,),
                  Skeleton(width: 50.w,height: 30.h,),
                  SizedBox(width: 5.h,),
                  Skeleton(width: 50.w,height: 30.h,),
                ],
              )

            ],
          )
        ],
      ),

    );
  }
}
