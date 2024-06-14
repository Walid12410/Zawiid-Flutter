import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../Color&Icons/color.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            GoRouter.of(context).goNamed('NotificationPage');
          },
          child: badges.Badge(
            badgeContent: Text(
              '8',
              style: TextStyle(color: tdWhite, fontSize: 10.sp),
            ),
            badgeStyle: const badges.BadgeStyle(badgeColor: tdBlack),
            position: badges.BadgePosition.custom(bottom: -7, end: -5),
            child: Image.asset(
              'assets/svg/notification.png',
              width: 25.w,
              height: 22.h,
              fit: BoxFit.fill,
              color: tdBlack,
            ),
          ),
        ),
        Container(
          height: 30.h,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(50).w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  GoRouter.of(context).goNamed('SearchPage');
                },
                child: Container(
                  width: 150.w,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ).w,
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 15.w,
                        ),
                        Center(
                          child: Text(
                            'Search for products',
                            style: TextStyle(fontSize: 7.sp, color: tdGrey),
                          ),
                        ),
                        SizedBox(
                          width: 43.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: const Border(left: BorderSide(color: Colors.black)),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50.0),
                    ).w,
                    color: tdBlack,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4).w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(width: 10.w),
                          Text(
                            'All Categories',
                            style: TextStyle(fontSize: 9.sp, color: tdWhite),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          SizedBox(
                              height: 40.h,
                              width: 30.w,
                              child: Center(
                                  child: SvgPicture.asset(
                                'assets/svg/search.svg',
                                fit: BoxFit.cover,
                              ))),
                          SizedBox(width: 5.w),
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
            context.push(context.namedLocation('CartPage'));
          },
          child: badges.Badge(
            badgeContent: Text(
              '0',
              style: TextStyle(color: tdWhite, fontSize: 10.sp),
            ),
            badgeStyle: const badges.BadgeStyle(badgeColor: tdBlack),
            position: badges.BadgePosition.custom(bottom: -7, end: -5),
            child: Image.asset(
              'assets/svg/cart.png',
              width: 25.w,
              height: 22.h,
              fit: BoxFit.fill,
              color: tdBlack,
            ),
          ),
        ),
      ],
    );
  }
}
