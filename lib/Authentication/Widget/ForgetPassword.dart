import 'package:flutter/material.dart';
import 'package:zawiid/Color&Icons/color.dart';

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () {
              //forget pass nav
            },
            child:  Text(
              'FORGOT PASSWORD?',
              style: TextStyle(
                  fontSize: screenWidth * 0.034,
                  fontWeight: FontWeight.bold,
                  color: tdGrey),
            ))
      ],
    );
  }
}
