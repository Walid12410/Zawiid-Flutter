import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:zawiid/Widget/PageHeadWidget.dart';
import 'package:zawiid/generated/l10n.dart';
import 'Widget/PrivacyPolicyImage.dart';

class PolicyPrivacy extends StatefulWidget {
  const PolicyPrivacy({super.key});

  @override
  State<PolicyPrivacy> createState() => _PolicyPrivacyState();
}

class _PolicyPrivacyState extends State<PolicyPrivacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageHeadView(title: S.of(context).privacyPolicy, onPressed: (){
                GoRouter.of(context).go("/Profile");
              }),
              SizedBox(height: 5.h),
              const PrivacyPolicyImage()
            ],
          ),
        ),
      ),
    );
  }
}


