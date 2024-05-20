import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/Color&Icons/color.dart';

class TimeContainer extends StatelessWidget {
  final String label;
  final int value;

  const TimeContainer({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8).w,
          child: Container(
            width: 35.w,
            height: 30.h,
            margin:const EdgeInsets.all(5).w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5).w,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset:const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                  '$value',
                  style:  TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold,color: tdGrey),
                ),
            ),

          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 7.sp,color: tdGrey ),
        ),
      ],
    );
  }
}
