import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Color&Icons/color.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,required this.onPressed
  });

  final VoidCallback onPressed;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1).w,
      child: GestureDetector(
        onTap: () {
          //GoRouter.of(context).go("/home");
          onPressed();
        },
        child: Container(
          width: double.infinity,
          height: 35.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50).w, color: tdBlack),
          child: Padding(
            padding: const EdgeInsets.all(5).w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 30.w),
                 Text(
                  'LOG IN',
                  style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold,
                      color: tdWhite),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8).w,
                  child: Container(
                      width: 22.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                          color: tdWhite,
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
