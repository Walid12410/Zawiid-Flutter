import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/generated/l10n.dart';

class GuestViewProfile extends StatelessWidget {
  const GuestViewProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            S.of(context).loginError,
            style: TextStyle(
              fontSize: 15.sp,
              color: tdBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5.h),
        GestureDetector(
          onTap: () {
            GoRouter.of(context).goNamed('SignIn');
          },
          child: Container(
            width: 90.w,
            height: 25.h,
            decoration: BoxDecoration(
              border: Border.all(color: tdGrey),
              borderRadius: BorderRadius.circular(20).w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.person,
                  size: 20.w,
                  color: tdBlack,
                ),
                Text(
                  S.of(context).logIn,
                  style: TextStyle(
                    fontSize: 9.sp,
                    color: tdBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        GestureDetector(
          onTap: () {
            GoRouter.of(context).goNamed('SignUp');
          },
          child: Container(
            height: 25.h,
            width: 90.w,
            decoration: BoxDecoration(
              border: Border.all(color: tdGrey),
              color: tdBlack,
              borderRadius: BorderRadius.circular(20).w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.person,
                  size: 20.w,
                  color: tdWhite,
                ),
                Text(
                  S.of(context).signUp,
                  style: TextStyle(
                    fontSize: 9.sp,
                    color: tdWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
