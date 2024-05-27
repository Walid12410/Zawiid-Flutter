import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Color&Icons/color.dart';

import 'Widget/ForgetPasswordTitleAndDetails.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ForgetPasswordTitleAndDetails(),
              Padding(
                padding: const EdgeInsets.only(right: 45,left: 45).w,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: tdWhite,
                    borderRadius: BorderRadius.circular(10).w,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 5).w,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15).w,
                          child: SvgPicture.asset(
                            'assets/svg/001-mail.svg',
                            width: 10.w,
                            height: 12.h,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            style: TextStyle(fontSize: 9.sp),
                            decoration: InputDecoration(
                              labelText: 'EMAIL/PHONE NUMBER',
                              labelStyle: TextStyle(fontSize: 9.sp, color: tdGrey),
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
                padding: const EdgeInsets.only(right: 45,left: 45).w,
                child: GestureDetector(
                  onTap: (){
                    context.push(context.namedLocation('CodeReceivePage'));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50).w,
                      border: Border.all(color: tdBlack)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10).w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 15.w,),
                          Text('Recover Password',style: TextStyle(fontSize: 7.sp,color: tdBlack,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                          Icon(Icons.arrow_forward_ios,color: tdBlack,size: 15.w,)
                        ],
                      ),
                    )
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

