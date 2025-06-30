import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:zawiid/provider/Cart_Provider.dart';
import 'package:intl/intl.dart';
import 'package:zawiid/provider/NotificationProvider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: true);
    var cartLength = cart.cartUser;
    final notificationProvider =
        Provider.of<NotificationsProvider>(context, listen: true);
    var notLength = notificationProvider.allNotification;

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
              '${notLength.length}',
              style: TextStyle(color: tdWhite, fontSize: 10.sp),
            ),
            badgeStyle: const badges.BadgeStyle(badgeColor: tdBlack),
            position: isArabic()
                ? badges.BadgePosition.custom(bottom: -5, start: -7)
                : badges.BadgePosition.custom(bottom: -7, end: -5),
            child: SvgPicture.asset(
              'assets/svg/inbox-2-svgrepo-com.svg',
              width: 25.w,
              height: 22.h,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
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
                            S.of(context).searchTitle,
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
                    borderRadius: isArabic()
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomLeft: Radius.circular(50.0),
                          ).w
                        : const BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomRight: Radius.circular(50.0),
                          ).w,
                    color: tdBlack,
                  ),
                  child: Center(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
                              .w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(width: 5.w),
                          Text(
                            S.of(context).allCategories,
                            style: TextStyle(fontSize: 9.sp, color: tdWhite),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                              height: 20.h,
                              width: 20.w,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: tdWhite,
                              ),
                              child: Center(
                                  child: SvgPicture.asset(
                                'assets/svg/search.svg',
                                width: 10.w,
                                height: 10.h,
                                fit: BoxFit.contain,
                                color: tdBlack,
                              ))),
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
              '${cartLength.length}',
              style: TextStyle(color: tdWhite, fontSize: 10.sp),
            ),
            badgeStyle: const badges.BadgeStyle(badgeColor: tdBlack),
            position: isArabic()
                ? badges.BadgePosition.custom(bottom: -5, start: -7)
                : badges.BadgePosition.custom(bottom: -7, end: -5),
            child: SvgPicture.asset(
              'assets/svg/bag-2-svgrepo-com.svg',
              width: 25.w,
              height: 22.h,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}
