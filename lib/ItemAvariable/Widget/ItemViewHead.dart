import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../Color&Icons/color.dart';


class ItemCategoriesHead extends StatelessWidget {
  const ItemCategoriesHead({
    super.key,required this.title
  });

  final String title;

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
            child: Text(title,
                style: TextStyle(
                    color: tdBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp)),
          ),
          SizedBox(
            width: 20.w,
          )
        ],
      ),
    );
  }
}
