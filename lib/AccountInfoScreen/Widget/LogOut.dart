import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Color&Icons/color.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).goNamed('SignIn');
      },
      child: Container(
        width: 100.w,
        height: 25.h,
        decoration: BoxDecoration(
            border: Border.all(color: tdGrey),
            borderRadius: BorderRadius.circular(15).w),
        child: Center(
          child: Text(
            'LOG OUT',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                color: tdGrey),
          ),
        ),
      ),
    );
  }
}
