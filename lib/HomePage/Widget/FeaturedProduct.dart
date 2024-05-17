import 'package:flutter/material.dart';

import '../../Color&Icons/color.dart';

class FeaturedProductCard extends StatelessWidget {
  const FeaturedProductCard({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IntrinsicWidth(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                ),
              ],
              color: tdWhiteNav),
          child: Row(
            children: [
              SizedBox(width: screenWidth * 0.05),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.02,
                    vertical: screenWidth * 0.01),
                child: SizedBox(
                    width: screenWidth * 0.3,
                    child: Image.asset(
                      'assets/img/camera.png',
                      fit: BoxFit.fill,
                    )),
              ),
              SizedBox(width: screenWidth * 0.04),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CATCH BIG',
                    style:
                    TextStyle(color: tdBlack, fontSize: screenWidth * 0.05),
                  ),
                  Row(
                    children: [
                      Text(
                        'DEALS ',
                        style: TextStyle(
                            color: tdBlack,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'ON THE',
                        style: TextStyle(
                            color: tdBlack, fontSize: screenWidth * 0.05),
                      )
                    ],
                  ),
                  Text(
                    'CAMERAS',
                    style:
                    TextStyle(fontSize: screenWidth * 0.05, color: tdBlack),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    'Shop now',
                    style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                        color: tdBlack),
                  )
                ],
              ),
              SizedBox(
                width: screenWidth * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
