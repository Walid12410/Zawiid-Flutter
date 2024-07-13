import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Color&Icons/color.dart';


class TimerWeekDeal extends StatelessWidget {
  const TimerWeekDeal({super.key, required this.name,required this.value});

  final int value;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5,right: 5,bottom: 5).w,
      child: Container(
        width: 47.w,
        decoration: BoxDecoration(
            color: tdWhite,
            border: Border.all(color: tdGrey),
            borderRadius: BorderRadius.circular(5).w),
        child: Padding(
          padding: const EdgeInsets.all(8.0).w,
          child: Column(
            children: [
              Text(
                '$value',
                style: TextStyle(fontSize: 15.sp, color: tdGrey,fontWeight: FontWeight.bold),
              ),
              Text(
                name,
                style: TextStyle(fontSize: 6.sp, color: tdGrey),
              ),
              SizedBox(height: 2.h,),
            ],
          ),
        ),
      ),
    );
  }
}
