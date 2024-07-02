import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;

import '../../Color&Icons/color.dart';
class ItemDetailsHead extends StatelessWidget {
  const ItemDetailsHead({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.only(right: 15,left: 12,top: 15).w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              context.pop();
            },
            child: SizedBox(
              width: 20.w,
              height: 18.h,
              child: Image.asset('assets/img/pop.png', fit: BoxFit.contain),
            ),
          ),
          GestureDetector(
            onTap: () {
              context.push(context.namedLocation('CartPage'));
            },
            child: badges.Badge(
              badgeContent: Text(
                '3',
                style: TextStyle(color: tdWhite,fontSize: 10.sp),
              ),
              badgeStyle: const badges.BadgeStyle(badgeColor: tdBlack),
              position: badges.BadgePosition.bottomEnd(),
              child: Image.asset(
                'assets/svg/cart.png',
                width: 25.w,
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
