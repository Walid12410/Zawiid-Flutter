import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/Color&Icons/color.dart';

class TermsAndPrivacySignIn extends StatelessWidget {
  const TermsAndPrivacySignIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Text.rich(
      TextSpan(
        text: 'By creating an account, you agree to our ',
        style: TextStyle(
          fontSize: 9.sp,
          color: tdBlack,
          fontWeight: FontWeight.w400
        ),
        children: const <TextSpan>[
          TextSpan(
            text: 'Terms of Service',
            style: TextStyle(
              color: tdBlack,
            ),
          ),
          TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(
              color: tdBlack,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
