import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Color&Icons/color.dart';

class CartItemView extends StatelessWidget {
  const CartItemView(
      {super.key,
        required this.title,
        required this.desc,
        required this.mainPrice,
        required this.salePrice});

  final String title;
  final String desc;
  final double mainPrice;
  final double salePrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      height: 230.h,
      decoration: BoxDecoration(
        color: tdWhite,
        borderRadius: BorderRadius.circular(10).w,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: 90.w,
              height: 100.h,
              child: Image.asset(
                'assets/img/iphone.png',
                fit: BoxFit.fill,
              )),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20).w,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 12.sp, color: tdBlack, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15).w,
            child: Text(
              desc,
              style: TextStyle(
                fontSize: 8.sp,
                color: tdBlack,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            '$salePrice KD',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: Colors.red),
          ),
          Text(
            '$mainPrice kD',
            style: TextStyle(
              fontSize: 10.sp, color: tdBlack,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.lineThrough,
              decorationThickness:
              2.5, // Adjust the thickness of the line through
              decorationColor: tdGrey,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10).w,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 25.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: tdBlack, borderRadius: BorderRadius.circular(5).w),
                child: Center(
                  child: Text(
                    'Add to cart',
                    style: TextStyle(fontSize: 8.sp, color: tdWhite),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5.h)
        ],
      ),
    );
  }
}
