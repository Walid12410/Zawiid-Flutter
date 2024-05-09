import 'package:flutter/material.dart';

import '../../../Color&Icons/color.dart';
import 'optionContainer.dart';

class CustomServicesContainer extends StatelessWidget {
  const CustomServicesContainer({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        decoration: const BoxDecoration(
          color: tdWhiteNav,
        ),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.01,),
            SizedBox(
                width: screenWidth * 0.5,
                height: screenHeight * 0.25,
                child: Image.asset(
                    'assets/img/CustomerService/CustomerServices.png',
                    fit: BoxFit.contain)),
            SizedBox(height: screenHeight * 0.02),
            Text(
              'Tell us how we can help',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.07,
                color: tdBlack,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            OptionContainer(screenHeight: screenHeight, screenWidth: screenWidth),
          ],
        ),
      ),
    );
  }
}
