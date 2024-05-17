import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zawiid/Color&Icons/color.dart';

class TabCard extends StatelessWidget {
  const TabCard({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.names,
  });

  final double screenWidth;
  final double screenHeight;
  final List<String> names;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.02),
      child: Container(
        width: screenWidth * 0.45,
        decoration: BoxDecoration(
          color: tdWhite,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(5.0, 5.0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Text(
                names[0],
                style: TextStyle(
                    fontSize: screenWidth * 0.025, color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Center(
                child: SizedBox(
                  width: screenWidth * 0.3,
                  child: Image.asset(
                    'assets/img/iphone.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '358.000 LB',
                    style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                  SvgPicture.asset(
                    'assets/svg/buy.svg',
                    width: screenWidth * 0.08,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              const Divider(),
              Text(
                'SKU: FT00962',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.033,
                    color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
