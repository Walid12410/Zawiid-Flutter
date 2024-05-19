import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;

import '../../Color&Icons/color.dart';
class ItemDetailsHead extends StatelessWidget {
  const ItemDetailsHead({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(right: screenWidth * 0.04,left: screenWidth * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              GoRouter.of(context).go("/home");
            },
            child: SizedBox(
              width: screenWidth * 0.07,
              height: screenHeight * 0.09,
              child: Image.asset('assets/img/pop.png', fit: BoxFit.contain),
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
      ),
    );
  }
}
