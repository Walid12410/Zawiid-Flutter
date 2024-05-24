import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/Color&Icons/color.dart';

class TimeContainer2 extends StatelessWidget {
  final String label;
  final int value;

  const TimeContainer2({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5).w,
          child: Container(
            width: 45.w,
            height: 32.h,
            margin:const EdgeInsets.all(5).w,
            decoration: BoxDecoration(
              color: tdWhite,
              borderRadius: BorderRadius.circular(10).w,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  offset:const Offset(0, 0),
                ),
              ],
            ),
            child: Center(
              child: Text(
                  '$value',
                  style:  TextStyle(fontSize: 10.sp,fontWeight: FontWeight.bold,color: tdGrey),
                ),
            ),

          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 5.sp,color: tdGrey ),
        ),
      ],
    );
  }
}
