import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Authentication/Widget/SignInButton.dart';
import 'package:zawiid/Authentication/Widget/SignInTextfield.dart';
import 'package:zawiid/Authentication/Widget/Terms&PrivacySignIn.dart';
import 'package:zawiid/Color&Icons/color.dart';

import 'Widget/ForgetPassword.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: tdGreen,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(20).w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Image.asset(
                                  'assets/log/LOGO-icon---Black.png',
                                  width: 200.w,
                                  height: 130.h,
                                  fit: BoxFit.contain,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10.h),
                           Text(
                            'Log In',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 21.sp,
                              color: tdBlack,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.push(context.namedLocation('SignUp'));
                              },
                            child:  Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 21.sp, color: tdGrey),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          const SignInTextFieldWidget(),
                          SizedBox(height: 15.h),
                          const SignInButton(),
                          SizedBox(
                            height: 10.h,
                          ),
                          const ForgetPasswordWidget()
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar:  BottomAppBar(
        elevation: 0,
        color: tdGreen,
        child: Padding(
          padding:const EdgeInsets.symmetric(vertical: 7, horizontal: 20).w,
          child:const TermsAndPrivacySignIn(),
        ),
      ),
    );
  }
}

