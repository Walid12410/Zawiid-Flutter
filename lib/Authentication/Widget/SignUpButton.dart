import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/Color&Icons/color.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1).w,
      child: GestureDetector(
        onTap: () {
          //signup
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
                SizedBox(width: 20.w),
                 Text(
                  'SIGN UP',
                  style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      color: tdBlack),
                   textAlign: TextAlign.center,
                ),
                Container(
                    width: 25.w,
                    height: 25.h,
                    decoration: BoxDecoration(
                        color: tdBlack,
                        borderRadius: BorderRadius.circular(20).w),
                    child:  Icon(
                      Icons.arrow_forward_ios,
                      size: 20.w,
                      color: tdGreen,
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
