import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/generated/l10n.dart';

class TermsAndPrivacySignIn extends StatelessWidget {
  const TermsAndPrivacySignIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '${S.of(context).byCreatingAccount} ',
        style: TextStyle(
          fontSize: 9.sp,
          color: tdBlack,
          fontWeight: FontWeight.w400
        ),
        children:  <TextSpan>[
          TextSpan(
            text: S.of(context).termsOfService,
            style: TextStyle(
              color: tdBlack,
              fontSize: 9.sp
            ),
          ),
          TextSpan(text: ' ${S.of(context).and} ' , ),
          TextSpan(
            text: S.of(context).privacyPolicyS,
            style: TextStyle(
              color: tdBlack,
              fontSize: 9.sp
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
