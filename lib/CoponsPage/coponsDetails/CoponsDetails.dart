import 'package:flutter/material.dart';
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
              SizedBox(height: screenHeight * 0.01),
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
                    padding: EdgeInsets.all(screenWidth * 0.01),
                    child: Column(
                      children: [
                        CouponsCardDetails(screenWidth: screenWidth, screenHeight: screenHeight),
                        SizedBox(height: screenHeight * 0.04),
                        CouponsCardDetails(screenWidth: screenWidth, screenHeight: screenHeight),
                        SizedBox(height: screenHeight * 0.04),
                        CouponsCardDetails(screenWidth: screenWidth, screenHeight: screenHeight),
                        SizedBox(height: screenHeight * 0.04),
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



