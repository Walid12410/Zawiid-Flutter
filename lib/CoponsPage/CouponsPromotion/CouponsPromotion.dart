import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'Widget/CouponsPromotionDetails.dart';
import 'Widget/CouponsPromotionHead.dart';


class CouponsPromotion extends StatefulWidget {
  const CouponsPromotion({super.key});

  @override
  State<CouponsPromotion> createState() => _CouponsPromotionState();
}

class _CouponsPromotionState extends State<CouponsPromotion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CouponsPromotionHead(),
            SizedBox(height: 2.h,),
            const CouponsPromotionDetails()
          ],
        ),
      )),
    );
  }
}



