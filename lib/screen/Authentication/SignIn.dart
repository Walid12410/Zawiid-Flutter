import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/localization/generated/l10n.dart';
import 'package:zawiid/screen/Authentication/Details/SignInButton.dart';
import 'package:zawiid/screen/Authentication/Details/SignInTextfield.dart';
import 'package:zawiid/screen/Authentication/Details/Terms&PrivacySignIn.dart';
import 'AlertDialog/AlertLogin.dart';
import 'Details/ForgetPassword.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key? key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AlertLogin alertLogin = AlertLogin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdGreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30.h,),
                  Center(
                    child: Image.asset(
                      'assets/log/LOGO-icon---Black.png',
                      width: 170.w,
                      height: 170.h,
                      fit: BoxFit.contain,
                    ),
                  ),
              Padding(
                padding: const EdgeInsets.only(left: 25,right: 25).w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).logIns,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19.sp,
                        color: tdBlack,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.push(context.namedLocation('SignUp'));
                      },
                      child:  Text(
                        S.of(context).signUps,
                        style: TextStyle(fontSize: 19.sp, color: tdGrey),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    SignInTextFieldWidget(emailController: emailController, passwordController: passwordController),
                    SizedBox(height: 10.h),
                     SignInButton(onPressed: (){
                       alertLogin.login(
                         context,
                         emailController.text,
                         passwordController.text,
                       );
                     }),
                    SizedBox(height: 10.h),
                    const ForgetPasswordWidget()
                  ],
                ),
              )
            ],
          ),
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


