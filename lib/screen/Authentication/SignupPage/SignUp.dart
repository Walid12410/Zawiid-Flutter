import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:zawiid/Api/AuthService.dart';
import 'package:zawiid/Widget/Toast/ToastError.dart';
import 'package:zawiid/Widget/Toast/ToastValidation.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/generated/l10n.dart';
import 'Details/GuestBottom.dart';
import 'Details/Terms&Privacy.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;


  void _validateForm() async{
    String errorMessage = "";
    if (emailController.text.isEmpty) {
      errorMessage += "Email is required. ";
    } else if (!EmailValidator.validate(emailController.text)) {
      errorMessage += "Enter a valid email address."; // Generic error message
    }
    // Validate password
    if (passwordController.text.isEmpty) {
      errorMessage += "Password is required. ";
    } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d).{7,}$')
        .hasMatch(passwordController.text)) {
      errorMessage +=
          "Password must be at least 7 characters long and contain both letters and numbers. ";
    }

    if (errorMessage.isEmpty) {
      Authentication service = Authentication();
      setState(() {
        isloading = true;
      });
      try {
        bool isRegister = await service.register(emailController.text, passwordController.text);
        if(isRegister){
          setState(() {
            GoRouter.of(context).go('/SignIn');
          });
        }
      } catch (e) {
        setState(() {
          showToast(S.of(context).errorConnection);
        });
      }finally{
        setState(() {
          isloading = false;
        });
      }
    } else {
      showValidationToast(errorMessage.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Center(
                child: Image.asset(
                  'assets/log/LOGO-icon---green.png',
                  width: 170.w,
                  height: 170.h,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25).w,
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
                      child: Text(
                        S.of(context).logIns,
                        style: TextStyle(fontSize: 19.sp, color: tdGrey),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15).w,
                        color: tdWhite,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5, left: 5).w,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: isArabic()
                                    ? const EdgeInsets.only(
                                            right: 15,
                                            left: 5,
                                            bottom: 5,
                                            top: 5)
                                        .w
                                    : const EdgeInsets.only(
                                            left: 15,
                                            right: 5,
                                            bottom: 5,
                                            top: 5)
                                        .w,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: isArabic()
                                          ? const EdgeInsets.only(left: 15).w
                                          : const EdgeInsets.only(right: 15).w,
                                      child: SvgPicture.asset(
                                        'assets/svg/001-mail.svg',
                                        width: 10.w,
                                        height: 12.h,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: emailController,
                                        cursorColor: tdGreen,
                                        style: TextStyle(fontSize: 9.sp),
                                        decoration: InputDecoration(
                                          labelText: S.of(context).email,
                                          labelStyle: TextStyle(
                                              fontSize: 9.sp, color: tdGrey),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: isArabic()
                                    ? const EdgeInsets.only(
                                            right: 15,
                                            left: 5,
                                            bottom: 5,
                                            top: 5)
                                        .w
                                    : const EdgeInsets.only(
                                            left: 15,
                                            right: 5,
                                            bottom: 5,
                                            top: 5)
                                        .w,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: isArabic()
                                          ? const EdgeInsets.only(left: 15).w
                                          : const EdgeInsets.only(right: 15).w,
                                      child: SvgPicture.asset(
                                        'assets/svg/002-password.svg',
                                        width: 18.w,
                                        height: 18.h,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: passwordController,
                                        obscureText: true,
                                        cursorColor: tdGreen,
                                        style: TextStyle(fontSize: 9.sp),
                                        decoration: InputDecoration(
                                          labelText: S.of(context).password,
                                          labelStyle: TextStyle(
                                              fontSize: 9.sp, color: tdGrey),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: const EdgeInsets.all(1).w,
                      child: GestureDetector(
                        onTap: isloading ? null : () {
                          _validateForm();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 35.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50).w,
                              color: tdWhite),
                          child: Padding(
                            padding: const EdgeInsets.all(5).w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: 30.w),
                                Text(
                                  isloading ? S.of(context).check :S.of(context).signUps,
                                  style: TextStyle(
                                      fontSize: 9.sp,
                                      fontWeight: FontWeight.bold,
                                      color: tdBlack),
                                  textAlign: TextAlign.center,
                                ),
                                Padding(
                                  padding: isArabic()
                                      ? const EdgeInsets.only(left: 8).w
                                      : const EdgeInsets.only(right: 8).w,
                                  child: Container(
                                    width: 22.w,
                                    height: 20.h,
                                    decoration: BoxDecoration(
                                        color: tdBlack,
                                        borderRadius:
                                            BorderRadius.circular(200).w),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 10.w,
                                      color: tdGreen,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
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
        elevation: 0,
        color: tdBlack,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20).w,
          child: const TermsAndPrivacySignUp(),
        ),
      ),
    );
  }
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}
