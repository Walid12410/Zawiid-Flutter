import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/core/Color&Icons/color.dart';



class ForgetPasswordTitleAndDetails extends StatelessWidget {
  const ForgetPasswordTitleAndDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15,right: 15).w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: (){
                  context.pop();
                },
                child: SizedBox(
                    width: 20.w,
                    height: 15.h,
                    child: SvgPicture.asset('assets/svg/close.svg')),
              )
            ],),
        ),
        Center(
          child: Image.asset(
            'assets/log/LOGO-icon---Black.png',
            width: 170.w,
            height: 170.h,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 20.h),
        Text('Forget Password',style: TextStyle(fontSize: 12.sp,color: tdGrey,fontWeight: FontWeight.bold),),
        SizedBox(height: 10.h),
        Padding(
          padding: const EdgeInsets.only(right: 50,left: 50).w,
          child: Text('Enter the email address you used to create your account and we will email you a link to reset your password',style: TextStyle(
              fontSize: 12.sp,color: tdGrey
          ),textAlign: TextAlign.center,),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
