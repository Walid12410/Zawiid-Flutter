import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'Widget/GuestBottom.dart';
import 'Widget/SignUpButton.dart';
import 'Widget/SignUpTextfield.dart';
import 'Widget/Terms&PrivacySignUp.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: tdBlack,
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
                                  'assets/log/LOGO-icon---green.png',
                                  width: 200.w,
                                  height: 130.h,
                                  fit: BoxFit.contain,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10.h),
                           Text(
                            'Sign Up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 21.sp,
                              color: tdWhite,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.push(context.namedLocation('SignIn'));
                            },
                            child:  Text(
                              'Log In',
                              style: TextStyle(fontSize: 21.sp, color: tdGrey),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          const TextFieldWidgetSignUp(),
                          SizedBox(height: 10.h),
                          const SignUpButton(),
                          SizedBox(height: 10.h),
                          const GuestBottom()
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
      bottomNavigationBar: BottomAppBar(
        elevation: 0, // Remove the shadow
        color: tdBlack,
        child: Padding(
          padding:const  EdgeInsets.symmetric(vertical: 7, horizontal: 20).w,
          child:const TermsAndPrivacySignUp(),
        ),
      ),
    );
  }
}

