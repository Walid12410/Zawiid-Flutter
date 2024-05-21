import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Widget/CouponsCard.dart';
import 'Widget/CouponsHead.dart';

class CouponsMain extends StatefulWidget {
  const CouponsMain({super.key});

  @override
  State<CouponsMain> createState() => _CouponsMainState();
}

class _CouponsMainState extends State<CouponsMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CouponsHead(),
              SizedBox(height: 15.h),
              const CouponCard(),
              const CouponCard(),
              const CouponCard(),
              const CouponCard(),
              const CouponCard(),
            ],
          ),
        ),
      ),
    );
  }
}


