import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../Color&Icons/color.dart';

class NewPasswordDetails extends StatelessWidget {
  const NewPasswordDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
        SizedBox(height: 150.h),
        Text('Enter New Password',style: TextStyle(fontWeight: FontWeight.bold,color: tdBlack,fontSize: 12.sp),textAlign: TextAlign.center,),
        SizedBox(height: 5.h),
        Padding(
          padding: const EdgeInsets.only(right: 50,left: 50).w,
          child: Text('Your new password must be different From previously used password.',style: TextStyle(fontSize: 12.sp,color: tdBlack),textAlign: TextAlign.center,),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
