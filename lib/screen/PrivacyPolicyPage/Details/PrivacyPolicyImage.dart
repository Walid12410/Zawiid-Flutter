import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyImage extends StatelessWidget {
  const PrivacyPolicyImage({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10,right: 10).w,
        child: SizedBox(
          width: double.infinity,
          child: Image.asset('assets/img/PrivacyAndTermsImage/PrivacyAndPolicy.png',fit: BoxFit.fill,),
        )
    );
  }
}
