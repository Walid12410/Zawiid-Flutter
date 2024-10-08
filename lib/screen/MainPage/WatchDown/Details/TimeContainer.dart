import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/core/Color&Icons/color.dart';

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
          padding: const EdgeInsets.all(5).w,
          child: Container(
            width: 27.w,
            height: 20.h,
            margin:const EdgeInsets.all(5).w,
            decoration: BoxDecoration(
              color: tdWhite,
              borderRadius: BorderRadius.circular(2).w,
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
                  style:  TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,color: tdGrey),textAlign: TextAlign.center,
                ),
            ),

          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 4.sp,color: tdGrey ),
        ),
      ],
    );
  }
}
