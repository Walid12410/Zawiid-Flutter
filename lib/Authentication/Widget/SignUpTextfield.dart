import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:zawiid/generated/l10n.dart';


bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}


class TextFieldWidgetSignUp extends StatelessWidget {
  TextFieldWidgetSignUp({Key? key,
    required this.emailController,
    required this.passwordController})
      : super(key: key);

  TextEditingController emailController;
  TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius
            .circular(15)
            .w,
        color: tdWhite,
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 5, left: 5).w,
        child: Column(
          children: [
            Padding(
              padding: isArabic() ?
              const EdgeInsets.only(right: 15, left: 5, bottom: 5, top: 5)
                  .w : const EdgeInsets.only(left: 15, right: 5, bottom: 5, top: 5)
                  .w,
              child: Row(
                children: [
                  Padding(
                    padding: isArabic()? const EdgeInsets.only(left: 15).w :
                    const EdgeInsets.only(right: 15).w,
                    child: SvgPicture.asset(
                      'assets/svg/001-mail.svg',
                      width: 10.w,
                      height: 12.h, // Adjust height as needed
                      fit: BoxFit.fill, // Adjust the fit as needed
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      style: TextStyle(fontSize: 9.sp),
                      controller: emailController,
                      cursorColor: tdGreen,
                      decoration: InputDecoration(
                        labelText: S.of(context).email,
                        labelStyle: TextStyle(fontSize: 9.sp, color: tdGrey),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:isArabic() ?
              const EdgeInsets.only(right: 15, left: 5, bottom: 5, top: 5)
                  .w : const EdgeInsets.only(left: 15, right: 5, bottom: 5, top: 5)
                  .w,
              child: Row(
                children: [
                  Padding(
                    padding: isArabic()? const EdgeInsets.only(left: 15).w :
                    const EdgeInsets.only(right: 15).w,
                    child: SvgPicture.asset(
                      'assets/svg/002-password.svg',
                      width: 18.w,
                      height: 18.h, // Adjust height as needed
                      fit: BoxFit.fill, // Adjust the fit as needed
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
                        labelStyle: TextStyle(fontSize: 9.sp, color: tdGrey),
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
    );
  }
}