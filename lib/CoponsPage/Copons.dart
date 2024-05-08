import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Color&Icons/color.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.02),
              CouponsHead(screenWidth: screenWidth,screenHeight: screenHeight,),
              SizedBox(height: screenHeight * 0.05),
              CouponCard(screenHeight: screenHeight),
              CouponCard(screenHeight: screenHeight),
              CouponCard(screenHeight: screenHeight),
              CouponCard(screenHeight: screenHeight),
              CouponCard(screenHeight: screenHeight),
            ],
          ),
        ),
      ),
    );
  }
}


