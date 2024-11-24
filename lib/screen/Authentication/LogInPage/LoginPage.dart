import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Api/AuthService.dart';
import 'package:zawiid/Widget/Toast/ToastError.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import 'package:zawiid/screen/Authentication/LogInPage/Details/TextField.dart';
import 'package:zawiid/screen/Authentication/LogInPage/Details/Terms&Privacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void loginCheck(email, password) async {
    Authentication service = Authentication();
    setState(() {
      isLoading = true;
    });
    bool isLogin = await service.login(email, password);
    try {
      if (isLogin) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        int userId = prefs.getInt('userID') ?? 0;
        setState(() {
          Provider.of<AuthProvider>(context, listen: false).setUserId(userId);
          GoRouter.of(context).go('/home');
        });
      }
    } catch (e) {
      setState(() {
        showToast(S.of(context).errorConnection);
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdGreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Center(
                child: Image.asset(
                  'assets/log/LOGO-icon---Black.png',
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
                      child: Text(
                        S.of(context).signUps,
                        style: TextStyle(fontSize: 19.sp, color: tdGrey),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    SignInTextFieldWidget(
                        emailController: emailController,
                        passwordController: passwordController),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: isLoading
                          ? null
                          : () {
                              loginCheck(emailController.text,
                                  passwordController.text);
                            },
                      child: Container(
                        width: double.infinity,
                        height: 35.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50).w,
                            color: tdBlack),
                        child: Padding(
                          padding: const EdgeInsets.all(5).w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width: 30.w),
                              Text(
                                isLoading
                                    ? S.of(context).check
                                    : S.of(context).logIns,
                                style: TextStyle(
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.bold,
                                    color: tdWhite),
                              ),
                              Padding(
                                padding: isArabic()
                                    ? const EdgeInsets.only(left: 8).w
                                    : const EdgeInsets.only(right: 8).w,
                                child: Container(
                                  width: 22.w,
                                  height: 20.h,
                                  decoration: BoxDecoration(
                                      color: tdWhite,
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
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              context.push(
                                  context.namedLocation('ForgetPassword'));
                            },
                            child: Text(
                              S.of(context).forgotPassword,
                              style: TextStyle(
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.bold,
                                  color: tdGrey),
                            ))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: tdGreen,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20).w,
          child: const TermsAndPrivacySignIn(),
        ),
      ),
    );
  }
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}
