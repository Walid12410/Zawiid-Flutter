import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Color&Icons/color.dart';


class TimerWeekDeal extends StatelessWidget {
  const TimerWeekDeal({super.key, required this.name});

  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.w,
      decoration: BoxDecoration(
          color: tdWhite,
          border: Border.all(color: tdGrey),
          borderRadius: BorderRadius.circular(5).w),
      child: Padding(
        padding: const EdgeInsets.all(8.0).w,
        child: Column(
          children: [
            Text(
              '00',
              style: TextStyle(fontSize: 20.sp, color: tdGrey,fontWeight: FontWeight.bold),
            ),
            Text(
              name,
              style: TextStyle(fontSize: 7.sp, color: tdGrey),
            )
          ],
        ),
      ),
    );
  }
}