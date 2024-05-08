import 'package:flutter/material.dart';

import '../../Color&Icons/color.dart';


class UserProfileCard extends StatelessWidget {
  const UserProfileCard({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Walid Jallad',
              style: TextStyle(
                  color: tdGrey,
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'wjallad55@gmail.com',
              style: TextStyle(fontSize: screenWidth * 0.037, color: tdGrey),
            ),
            SizedBox(height: screenHeight * 0.01),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: screenWidth * 0.25,
                height: screenHeight * 0.03,
                decoration: BoxDecoration(
                    border: Border.all(color: tdGrey),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    'EDIT PROFILE',
                    style:
                    TextStyle(fontSize: screenWidth * 0.025, color: tdGrey),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
            width: screenWidth * 0.30,
            height: screenHeight * 0.1,
            child: Image.asset(
              'assets/img/User.png',
              fit: BoxFit.contain,
            ))
      ],
    );
  }
}
