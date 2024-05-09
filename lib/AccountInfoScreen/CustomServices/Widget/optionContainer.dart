import 'package:flutter/material.dart';

import '../../../Color&Icons/color.dart';
import 'ServiceCall.dart';
import 'ServiceOptionalCard.dart';

class OptionContainer extends StatelessWidget {
  const OptionContainer({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: tdWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'We’re here to help you at every step. Please look Through the options below and select what you’re looking for.',
                style: TextStyle(
                    color: tdBlack,
                    fontSize: screenWidth * 0.046),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            ServiceOptionCard(
                screenHeight: screenHeight,
                screenWidth: screenWidth),
            ServiceCallUs(screenHeight: screenHeight, screenWidth: screenWidth)
          ],
        ),
      ),
    );
  }
}
