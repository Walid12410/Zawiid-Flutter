import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Color&Icons/color.dart';

import 'Widget/NewPasswordDetails.dart';


class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const NewPasswordDetails(),
              Padding(
                padding: const EdgeInsets.only(right: 20,left: 20).w,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13).w,
                    border: Border.all(color: tdBlack)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 5).w,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15).w,
                          child: SvgPicture.asset(
                            'assets/svg/002-password.svg',
                            width: 12.w,
                            height: 14.h,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            obscureText: true,
                            style: TextStyle(fontSize: 12.sp),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(fontSize: 12.sp, color: tdGrey,fontWeight: FontWeight.bold),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: const EdgeInsets.only(right: 20,left: 20).w,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13).w,
                      border: Border.all(color: tdBlack)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 5).w,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15).w,
                          child: SvgPicture.asset(
                            'assets/svg/002-password.svg',
                            width: 12.w,
                            height: 14.h,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            obscureText: true,
                            style: TextStyle(fontSize: 12.sp),
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(fontSize: 12.sp, color: tdGrey,fontWeight: FontWeight.bold),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: const EdgeInsets.only(left: 50,right: 50).w,
                child: GestureDetector(
                  onTap: (){
                    GoRouter.of(context).go('/home');
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: tdBlack),
                      borderRadius: BorderRadius.circular(50).w
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10).w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 12.w,),
                          Text('Verify and Proceed',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 7.sp,color: tdBlack),textAlign: TextAlign.center,),
                          Icon(Icons.arrow_forward_ios,color: tdBlack,size: 12.w,)
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

