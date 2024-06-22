import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../Color&Icons/color.dart';

class GuestBottom extends StatelessWidget {
  const GuestBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1).w,
      child: GestureDetector(
        onTap: () {
          GoRouter.of(context).go("/home");
        },
        child: Container(
          width: double.infinity,
          height: 35.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50).w, color: tdWhite),
          child: Padding(
            padding: const EdgeInsets.all(5).w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 35.w),
                Text(
                  'CONTINUE AS A GUEST',
                  style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold,
                      color: tdBlack),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8).w,
                  child: Container(
                    width: 22.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                        color: tdBlack,
                        borderRadius: BorderRadius.circular(200).w),
                    child:  Icon(
                      Icons.arrow_forward_ios,
                      size: 10.w,
                      color: tdGreen,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
