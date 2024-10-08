import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import '../../Skeleton/Skeleton.dart';


class LoadingContainerTicket extends StatelessWidget {
  const LoadingContainerTicket({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 10).w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Skeleton(width: 30.w,height: 25.h,),
                    Skeleton(width: 50.w,height: 25.h,),
                    SizedBox(width: 20.w,)
                  ],
                ),
              ),
              SizedBox(height: 30.h,),
              Padding(
                padding: const EdgeInsets.all(5).w,
                child: Skeleton(width: double.infinity,height: 300.h,),
              ),
              SizedBox(height: 25.h,),
              Skeleton(width: 70.h,height: 20.h,),
              SizedBox(height: 10.h,),
              Skeleton(width: 200.h,height: 50.h,),
              SizedBox(height: 10.h,),
              Skeleton(height: 20.h,width: 100.w,)
            ],
          ),
        ),
      ),
    );
  }
}
