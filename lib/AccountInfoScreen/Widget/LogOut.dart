import 'package:flutter/material.dart';
import 'package:zawiid/Color&Icons/color.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: screenWidth * 0.26,
        height: screenHeight * 0.035,
        decoration: BoxDecoration(
            border: Border.all(color: tdGrey),
            borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Text(
            'LOG OUT',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.027,
                color: tdGrey),
          ),
        ),
      ),
    );
  }
}
