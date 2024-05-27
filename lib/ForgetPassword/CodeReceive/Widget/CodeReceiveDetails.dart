import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../Color&Icons/color.dart';


class CodeReceiveDetails extends StatelessWidget {
  const CodeReceiveDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, right: 15).w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  GoRouter.of(context).go('/SignIn');
                },
                child: SizedBox(
                    width: 20.w,
                    height: 15.h,
                    child: SvgPicture.asset('assets/svg/close.svg')),
              )
            ],
          ),
        ),
        SizedBox(height: 180.h),
        Text(
          'Get Your Code',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: tdBlack,
              fontSize: 12.sp),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: const EdgeInsets.only(right: 80, left: 80).w,
          child: Text(
            'Please enter the 4 digit code that Send to your email address',
            style: TextStyle(fontSize: 12.sp, color: tdBlack),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
