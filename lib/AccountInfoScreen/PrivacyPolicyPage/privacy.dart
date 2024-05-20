import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Color&Icons/color.dart';

import '../../Color&Icons/my_flutter_app_icons.dart';
import 'Widget/PrivacyHeader.dart';
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
              const PrivacyHeadPage(),
              SizedBox(height: 5.h),
              const PrivacyPolicyImage()
            ],
          ),
        ),
      ),
    );
  }
}


