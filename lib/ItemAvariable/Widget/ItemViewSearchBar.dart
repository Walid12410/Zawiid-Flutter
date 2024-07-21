import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import '../../Color&Icons/color.dart';
import '../../provider/Cart_Provider.dart';
import '../../provider/NotificationProvider.dart';

class ItemSearchBar extends StatelessWidget {
  const ItemSearchBar({
    super.key,required this.controller,required this.onSearch
  });
  final TextEditingController controller;
  final Function(String) onSearch;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: true);
    var cartLength = cart.cartUser;
    final notificationProvider = Provider.of<NotificationsProvider>(context, listen: true);
    var notLength = notificationProvider.allNotification;

    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 8).w,
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
          SizedBox(width: 1.w),
          Container(
            height: 30.h,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
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
                        hintText: 'Search for products',
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
                      borderRadius: BorderRadius.only(
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
      ),
    );
  }
}
