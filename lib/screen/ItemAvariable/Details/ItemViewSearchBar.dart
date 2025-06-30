import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:zawiid/provider/Cart_Provider.dart';
import 'package:zawiid/provider/NotificationProvider.dart';
import 'package:flutter_svg/flutter_svg.dart';

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

class ItemSearchBar extends StatelessWidget {
  const ItemSearchBar(
      {super.key, required this.controller, required this.onSearch});
  final TextEditingController controller;
  final Function(String) onSearch;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: true);
    final notificationProvider = Provider.of<NotificationsProvider>(context, listen: true);
    var cartLength = cart.cartUser;
    var notLength = notificationProvider.allNotification;

    return Padding(
      padding: isArabic()
          ? const EdgeInsets.only(right: 5, left: 8).w
          : const EdgeInsets.only(left: 5, right: 8).w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              context.push(context.namedLocation('NotificationPage'));
            },
            child: badges.Badge(
              badgeContent: Text(
                '${notLength.length}',
                style: TextStyle(color: tdWhite, fontSize: 10.sp),
              ),
              badgeStyle: const badges.BadgeStyle(badgeColor: tdBlack),
              position: isArabic()
                  ? badges.BadgePosition.custom(bottom: -7, start: -5)
                  : badges.BadgePosition.custom(bottom: -7, end: -5),
              child:  SvgPicture.asset(
              'assets/svg/inbox-2-svgrepo-com.svg',
              width: 25.w,
              height: 22.h,
              fit: BoxFit.fill,
            ),
            ),
          ),
          SizedBox(width: 1.w),
          Container(
            height: 30.h,
            decoration: BoxDecoration(
              border: Border.all(color: tdBlack),
              borderRadius: BorderRadius.circular(50).w,
            ),
            child: Row(
              children: [
                Container(
                  width: 233.w,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ).w,
                  ),
                  child: Center(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: S.of(context).searchTitle,
                        hintStyle: TextStyle(fontSize: 9.sp, color: tdGrey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                        isDense:
                            true, // To reduce the inner padding of the TextField
                      ),
                      style: TextStyle(fontSize: 12.sp),
                      onChanged: onSearch,
                    ),
                  ),
                ),
                Container(
                  width: 35.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                      color: tdBlack,
                      borderRadius: isArabic()
                          ? BorderRadius.only(
                              topLeft: const Radius.circular(20).w,
                              bottomLeft: const Radius.circular(20).w)
                          : BorderRadius.only(
                              topRight: const Radius.circular(20).w,
                              bottomRight: const Radius.circular(20).w)),
                  child: Center(
                    child: Icon(Icons.search, color: tdWhite, size: 20.w),
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
                  ? badges.BadgePosition.custom(bottom: -7, start: -5)
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
      ),
    );
  }
}
