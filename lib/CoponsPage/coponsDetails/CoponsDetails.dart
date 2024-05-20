import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'Widget/CouponsCardDetails.dart';
import 'Widget/CouponsCardHead.dart';
import 'Widget/TitleAndDescriptionCoupons.dart';

class CouponsDetails extends StatefulWidget {
  const CouponsDetails({super.key});

  @override
  State<CouponsDetails> createState() => _CouponsDetailsState();
}

class _CouponsDetailsState extends State<CouponsDetails> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CouponsCardHead(screenWidth: screenWidth, screenHeight: screenHeight),
              TitleAndDescription(
                  screenWidth: screenWidth, screenHeight: screenHeight),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.03),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: tdWhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: const Offset(4.0, 4.0),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:const EdgeInsets.all(5).w,
                    child: Column(
                      children: [
                        const CouponsCardDetails(),
                        SizedBox(height: 10.h),
                        const CouponsCardDetails(),
                        SizedBox(height: 10.h),
                        const CouponsCardDetails(),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



