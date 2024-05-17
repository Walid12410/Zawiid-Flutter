import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_svg/flutter_svg.dart';
import '../../Color&Icons/color.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
    required this.screenWidth,
    required this.screenHeight
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            //notification bottom
          },
          child: badges.Badge(
            badgeContent: const Text(
              '8',
              style: TextStyle(color: tdWhite),
            ),
            badgeStyle: const badges.BadgeStyle(badgeColor: tdBlack),
            position: badges.BadgePosition.bottomEnd(),
            child: Image.asset(
              'assets/svg/notification.png',
              width: screenWidth * 0.07,
              fit: BoxFit.fill,
              color: tdBlack,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: screenWidth * 0.06,
                        ),
                        Center(
                          child: Text(
                            'Search for products',
                            style: TextStyle(
                                fontSize: screenWidth * 0.025, color: tdGrey),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.09,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(left: BorderSide(color: Colors.black)),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50.0),
                    ),
                    color: tdBlack,
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02,
                          vertical: screenWidth * 0.01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'All Categories',
                            style: TextStyle(
                                fontSize: screenWidth * 0.033, color: tdWhite),
                          ),
                          SizedBox(
                            width: screenWidth * 0.03,
                          ),
                          SizedBox(
                            height: screenHeight *0.045,
                              width: screenWidth * 0.1,
                              child: Center(
                                  child: SvgPicture.asset('assets/svg/search.svg',
                                    fit: BoxFit.contain,))),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            //notification bottom
          },
          child: badges.Badge(
            badgeContent: const Text(
              '3',
              style: TextStyle(color: tdWhite),
            ),
            badgeStyle: const badges.BadgeStyle(badgeColor: tdBlack),
            position: badges.BadgePosition.bottomEnd(),
            child: Image.asset(
              'assets/svg/cart.png',
              width: screenWidth * 0.07,
              fit: BoxFit.fill,
              color: tdBlack,
            ),
          ),
        ),
      ],
    );
  }
}
