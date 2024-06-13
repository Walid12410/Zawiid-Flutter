import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/HomePage/Homepage.dart';
import '../../Color&Icons/color.dart';

class SearchBarText extends StatelessWidget {
  const SearchBarText({
    super.key,
    required FocusNode focusNode,
  }) : _focusNode = focusNode;

  final FocusNode _focusNode;

  void openDrawerFromAnotherPage(BuildContext context) {
    context.go('/home');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        HomePage.scaffoldKey.currentState?.openDrawer();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                context.push(context.namedLocation('NotificationPage'));
              },
              child: badges.Badge(
                badgeContent:  Text(
                  '8',
                  style: TextStyle(color: tdWhite,fontSize: 10.sp),
                ),
                badgeStyle: const badges.BadgeStyle(badgeColor: tdBlack),
                position: badges.BadgePosition.custom(bottom: -7,end: -5),
                child: Image.asset(
                  'assets/svg/notification.png',
                  width:  25.w,
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
                children: [
                  Container(
                    width: 150.w,
                    decoration:  BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                      ).w,
                    ),
                    child: TextField(
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        hintText: 'Search for products',
                        hintStyle: TextStyle(fontSize: 7.sp, color: tdGrey),
                        border: InputBorder.none,

                        contentPadding: const EdgeInsets.symmetric(horizontal: 15,
                            vertical: 12).w,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      openDrawerFromAnotherPage(context);
                    },
                    child: Container(
                      decoration:BoxDecoration(
                        border: const Border(left: BorderSide(color: Colors.black)),
                        borderRadius:const BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50.0),
                        ).w,
                        color: tdBlack,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4).w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'All Categories',
                                style: TextStyle(
                                    fontSize: 8.sp, color: tdWhite),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              SizedBox(
                                  height: 30.h,
                                  width: 30.w,
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
                context.push(context.namedLocation('CartPage'));
              },
              child: badges.Badge(
                badgeContent:  Text(
                  '3',
                  style: TextStyle(color: tdWhite,fontSize: 10.sp),
                ),
                badgeStyle: const badges.BadgeStyle(badgeColor: tdBlack),
                position: badges.BadgePosition.custom(bottom: -7,end: -5),
                child: Image.asset(
                  'assets/svg/cart.png',
                  width:  25.w,
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
