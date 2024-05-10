import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../Color&Icons/color.dart';

class LegalHeader extends StatelessWidget {
  const LegalHeader({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return  Row(
        children: [
          SizedBox(
            width: screenWidth * 0.05,
          ),
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                GoRouter.of(context).go("/profile");
              },
              child: SizedBox(
                width: screenWidth * 0.07,
                height: screenHeight * 0.09,
                child: Image.asset('assets/img/pop.png', fit: BoxFit.contain),
              ),
            ),
          ),
          const Expanded(
            flex: 4,
            child: Text(
              'Legal Information',
              style: TextStyle(
                  color: tdBlack, fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );

  }
}
