import 'package:flutter/material.dart';
import 'package:zawiid/Color&Icons/color.dart';

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () {
              //forget pass nav
            },
            child: const Text(
              'FORGOT PASSWORD?',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: tdGrey),
            ))
      ],
    );
  }
}
