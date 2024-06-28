import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Color&Icons/color.dart';

class CartItemView extends StatelessWidget {
  const CartItemView(
      {super.key,
        required this.title,
        required this.desc,
        required this.mainPrice,
        required this.salePrice,
      required this.image});

  final String title;
  final String desc;
  final String mainPrice;
  final String salePrice;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
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
          SizedBox(height: 10.h),
          SizedBox(
              width: 90.w,
              height: 110.h,
              child: CachedNetworkImage(
                imageUrl: image,
                placeholder: (context, url) => Image.asset('assets/log/LOGO-icon---Black.png'),
                errorWidget: (context, url, error) => Image.asset('assets/log/LOGO-icon---Black.png'),
              ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20).w,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 12.sp, color: tdBlack, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15).w,
            child: Text(
              formatDesc(desc),
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
              decorationThickness: 2.5, // Adjust the thickness of the line through
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
String formatDesc(String desc) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: desc, style: TextStyle(fontSize: 8.sp)),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  );
  textPainter.layout(minWidth: 0, maxWidth: double.infinity);
  final bool isOneLine = textPainter.didExceedMaxLines == false;
  return isOneLine ? '$desc\n' : desc;
}

