import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:badges/badges.dart' as badges;

class ItemViewCategories extends StatefulWidget {
  const ItemViewCategories({super.key});

  @override
  State<ItemViewCategories> createState() => _ItemViewCategoriesState();
}

class _ItemViewCategoriesState extends State<ItemViewCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ItemCategoriesHead(),
              SizedBox(height: 5.h,),
              const ItemSearchBar(),
              SizedBox(height: 10.h,),
              Container(
                decoration: BoxDecoration(
                  color: tdWhite,
                  borderRadius: BorderRadius.circular(20).w,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ItemSearchBar extends StatelessWidget {
  const ItemSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5,right: 8).w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              position: badges.BadgePosition.bottomEnd(),
              child: Image.asset(
                'assets/svg/notification.png',
                width: 25.w,
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
                  decoration:  BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ).w,
                  ),
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for products',
                          hintStyle: TextStyle(fontSize: 9.sp, color: tdGrey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                          isDense: true,  // To reduce the inner padding of the TextField
                        ),
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ),
                ),
               Container(
                 width: 35.w,
                 height: 30.h,
                 decoration: BoxDecoration(
                   color: tdBlack,
                   borderRadius: BorderRadius.only(
                     topRight:const Radius.circular(20).w,
                     bottomRight:const Radius.circular(20).w
                   )
                 ),
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
              badgeContent:  Text(
                '3',
                style: TextStyle(color: tdWhite,fontSize: 10.sp),
              ),
              badgeStyle: const badges.BadgeStyle(badgeColor: tdBlack),
              position: badges.BadgePosition.bottomEnd(),
              child: Image.asset(
                'assets/svg/cart.png',
                width:  25.w,
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

class ItemCategoriesHead extends StatelessWidget {
  const ItemCategoriesHead({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20).w,
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
              child: Image.asset('assets/img/pop2.png', fit: BoxFit.contain),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10).w,
            child: Text(
                'Accessories',
                style: TextStyle(
                    color: tdBlack, fontWeight: FontWeight.bold, fontSize: 15.sp)
            ),
          ),
          SizedBox(width: 20.w,)
        ],
      ),
    );
  }
}
