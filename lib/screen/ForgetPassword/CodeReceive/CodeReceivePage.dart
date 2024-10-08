import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:zawiid/core/Color&Icons/color.dart';

import 'Details/CodeReceiveDetails.dart';

class CodeReceivePage extends StatefulWidget {
  const CodeReceivePage({super.key});

  @override
  State<CodeReceivePage> createState() => _CodeReceivePageState();
}

class _CodeReceivePageState extends State<CodeReceivePage> {
  final defaultPinTheme = PinTheme(
    width: 40.w,
    height: 38.h,
    textStyle: TextStyle(
      fontSize: 12.sp,
      color: tdBlack,
      fontWeight: FontWeight.bold
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10).w, color: tdGreyHome1),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CodeReceiveDetails(),
              Pinput(
                length: 4,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!
                        .copyWith(border: Border.all(color: tdBlack))),
                onCompleted: (pin) => debugPrint(pin),
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () {
                  context.push(context.namedLocation('NewPassword'));
                },
                child: Container(
                  width: 160.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: tdBlack),
                      borderRadius: BorderRadius.circular(50).w),
                  child: Padding(
                    padding: const EdgeInsets.all(8).w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 10.w),
                        Text(
                          'Verify and Proceed',
                          style: TextStyle(
                              fontSize: 7.sp,
                              color: tdBlack,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: tdBlack,
                          size: 10.w,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                'If you don`t receive code!',
                style: TextStyle(fontSize: 12.sp, color: tdBlack),
                textAlign: TextAlign.center,
              ),
              GestureDetector(
                  onTap: () {
                    //resendCode
                  },
                  child: Text(
                    'Resend',
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: tdBlack,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

