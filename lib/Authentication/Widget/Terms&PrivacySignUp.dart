import 'package:flutter/material.dart';
import 'package:zawiid/Color&Icons/color.dart';

class TermsAndPrivacySignUp extends StatelessWidget {
  const TermsAndPrivacySignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Text.rich(
      TextSpan(
        text: 'By creating an account, you agree to our ',
        style: TextStyle(
          fontSize: screenWidth * 0.03,
          color: tdGrey,
        ),
        children: const <TextSpan>[
          TextSpan(
            text: 'Terms of Service',
            style: TextStyle(
              color: tdGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(
              color: tdGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
