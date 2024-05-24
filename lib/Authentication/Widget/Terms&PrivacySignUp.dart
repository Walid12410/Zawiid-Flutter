import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/Color&Icons/color.dart';

class TermsAndPrivacySignUp extends StatelessWidget {
  const TermsAndPrivacySignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Text.rich(
      TextSpan(
        text: 'By creating an account, you agree to our ',
        style: TextStyle(
          fontSize: 9.sp,
          color: tdGrey,
            fontWeight: FontWeight.w400
        ),
        children: const <TextSpan>[
          TextSpan(
            text: 'Terms of Service',
            style: TextStyle(
              color: tdGreen,
              fontWeight: FontWeight.w400,

            ),
          ),
          TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(
              color: tdGreen,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
