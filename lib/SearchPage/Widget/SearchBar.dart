import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../Color&Icons/color.dart';

class SearchBarText extends StatelessWidget {
  const SearchBarText({
    super.key,
    required FocusNode focusNode,
  }) : _focusNode = focusNode;

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
        Container(
          height: 30.h,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(50).w,
          ),
          child: Row(
            children: [
              Container(
                width: 140.w,
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
                    hintStyle: TextStyle(fontSize: 9.sp, color: tdGrey),
                    border: InputBorder.none,

                    contentPadding: const EdgeInsets.symmetric(horizontal: 15,
                        vertical: 12).w,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
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
                                fontSize: 12.sp, color: tdWhite),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          SizedBox(
                              height: 40.h,
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
            //notification bottom
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
    );
  }
}
