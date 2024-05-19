import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_svg/svg.dart';
import '../../Color&Icons/color.dart';

class SearchBarText extends StatelessWidget {
  const SearchBarText({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required FocusNode focusNode,
  }) : _focusNode = focusNode;

  final double screenWidth;
  final double screenHeight;
  final FocusNode _focusNode;

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
            badgeContent:  Text(
              '8',
              style: TextStyle(color: tdWhite,fontSize: screenWidth * 0.03),
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
          height: screenHeight * 0.045,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: [
              Container(
                width: screenWidth * 0.38,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                ),
                child: TextField(
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    hintText: 'Search for products',
                    hintStyle: TextStyle(fontSize: screenWidth * 0.025, color: tdGrey),
                    border: InputBorder.none,

                    contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06,
                        vertical: screenHeight * 0.016),
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
                              height: screenHeight *0.2,
                              width: screenWidth * 0.1,
                              child: Center(
                                  child: SvgPicture.asset('assets/svg/search.svg',
                                    fit: BoxFit.cover,))),
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
            badgeContent:  Text(
              '3',
              style: TextStyle(color: tdWhite,fontSize: screenWidth * 0.03),
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
