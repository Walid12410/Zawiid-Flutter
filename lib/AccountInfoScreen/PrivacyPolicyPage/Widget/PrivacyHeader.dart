import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../Color&Icons/color.dart';

class PrivacyHeadPage extends StatelessWidget {
  const PrivacyHeadPage({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30,right: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              GoRouter.of(context).go('/home');
            },
            child: SizedBox(
              width: screenWidth * 0.07,
              height: screenHeight * 0.09,
              child: Image.asset(
                'assets/img/pop.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
              width: screenWidth * 0.3,
              height: screenHeight * 0.1,
              child: Center(child: Text('Privacy Policy',style: TextStyle(fontSize: screenWidth * 0.04,fontWeight: FontWeight.bold,color: tdBlack),))),
          const SizedBox(),
        ],
      ),
    );
  }
}
