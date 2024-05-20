import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Color&Icons/color.dart';


class UserProfileCard extends StatelessWidget {
  const UserProfileCard({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Walid Jallad',
              style: TextStyle(
                  color: tdGrey,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'wjallad55@gmail.com',
              style: TextStyle(fontSize: 15.sp, color: tdGrey,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.h),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 100.w,
                height: 20.h,
                decoration: BoxDecoration(
                    border: Border.all(color: tdGrey),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    'EDIT PROFILE',
                    style:
                    TextStyle(fontSize: 10.sp, color: tdGrey),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
            width: 75.w,
            height: 70.h,
            child: Image.asset(
              'assets/img/User.png',
              fit: BoxFit.fill,
            ))
      ],
    );
  }
}
