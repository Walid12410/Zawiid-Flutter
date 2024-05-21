import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Color&Icons/color.dart';

class TabCard extends StatelessWidget {
  const TabCard({
    super.key,
    required this.names,
  });
  final List<String> names;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        GoRouter.of(context).goNamed('itemDetails');
      },
      child: Padding(
        padding: const EdgeInsets.all(5).w,
        child: Container(
          width: 165.w,
          decoration: BoxDecoration(
            color: tdWhite,
            borderRadius: BorderRadius.circular(5).w,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 5,
                offset: const Offset(5.0, 5.0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0).w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  names[0],
                  style: TextStyle(
                      fontSize: 8.sp, color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Center(
                  child: SizedBox(
                    width: 100.w,
                    height: 130.h,
                    child: Image.asset(
                      'assets/img/iphone.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '358.000 LB',
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    SvgPicture.asset(
                      'assets/svg/buy.svg',
                      width: 27.w,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                const Divider(),
                Text(
                  'SKU: FT00962',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
