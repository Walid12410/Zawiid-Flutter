import 'package:flutter/material.dart';
import 'package:zawiid/Color&Icons/color.dart';

class TermsAndPrivacySignIn extends StatelessWidget {
  const TermsAndPrivacySignIn({
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
          color: tdBlack,
        ),
        children: const <TextSpan>[
          TextSpan(
            text: 'Terms of Service',
            style: TextStyle(
              color: tdBlack,
            ),
          ),
          TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(
              color: tdBlack,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
