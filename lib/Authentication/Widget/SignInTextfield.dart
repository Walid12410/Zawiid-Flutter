import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInTextFieldWidget extends StatelessWidget {
  const SignInTextFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15).w,
        color: tdWhite,
      ),
      child: Padding(
        padding: const EdgeInsets.all(5).w,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5).w,
              child: TextFormField(
                style:  TextStyle(fontSize: 10.sp),
                decoration: InputDecoration(
                  labelText: 'EMAIL',
                  labelStyle:  TextStyle(fontSize: 11.sp, color: tdGrey),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right:  20).w,
                    child: SvgPicture.asset('assets/svg/001-mail.svg',
                      width: 5.w,height: 5.h,),
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5).w,
              child: TextFormField(
                obscureText: true,
                style:  TextStyle(fontSize: 15.sp),
                decoration: InputDecoration(
                  labelText: 'PASSWORD',
                  labelStyle:  TextStyle(fontSize: 11.sp, color: tdGrey),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right:  20).w,
                    child: SvgPicture.asset('assets/svg/002-password.svg',
                    width: 5.w,height: 5.h,),
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
