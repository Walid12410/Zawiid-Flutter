import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/localization/generated/l10n.dart';
import 'AlertDialog/AlertSignUp.dart';
import 'Details/GuestBottom.dart';
import 'Details/SignUpButton.dart';
import 'Details/SignUpTextfield.dart';
import 'Details/Terms&PrivacySignUp.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AlertSignUp alertSignUp = AlertSignUp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30.h,),
              Center(
                child: Image.asset(
                  'assets/log/LOGO-icon---green.png',
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
                      S.of(context).signUps,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19.sp,
                        color: tdWhite,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.push(context.namedLocation('SignIn'));
                      },
                      child:  Text(
                        S.of(context).logIns,
                        style: TextStyle(fontSize: 19.sp, color: tdGrey),
                      ),
                    ),
                    SizedBox(height: 10.h),
                     TextFieldWidgetSignUp(emailController: emailController,passwordController: passwordController,),
                    SizedBox(height: 20.h),
                     SignUpButton(onPressed: (){
                       alertSignUp.register(context, emailController.text, passwordController.text);
                     },),
                    SizedBox(height: 10.h),
                    const GuestBottom()
                  ],
                ),
              )
            ],
          ),
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

