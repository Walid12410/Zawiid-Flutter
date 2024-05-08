import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../Color&Icons/my_flutter_app_icons.dart';

class ProfileHeadPage extends StatelessWidget {
  const ProfileHeadPage({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 70),
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
          Icon(
            MyFlutterApp.group_168,
            size: screenWidth * 0.14,
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}
