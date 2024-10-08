import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/core/Color&Icons/color.dart';

class TicketDetails extends StatelessWidget {
  const TicketDetails(
      {Key? key,
      required this.onTap,
      required this.mark,
      required this.color,
      required this.productName,
      required this.size})
      : super(key: key);

  final VoidCallback onTap;
  final String color;
  final String mark;
  final String productName;
  final String size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 30, left: 50).w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 3.w,
                ),
                Text(
                  mark,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: tdBlack,
                    fontSize: 18.sp,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                GestureDetector(
                  onTap: onTap,
                  child: SizedBox(
                    width: 20.w,
                    height: 18.h,
                    child: Image.asset(
                      'assets/img/pop.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            productName,
            style: TextStyle(fontSize: 12.sp, color: tdGrey),
            textAlign: TextAlign.center,
          ),
          Text(
            color,
            style: TextStyle(fontSize: 12.sp, color: tdGrey),
          ),
          SizedBox(height: 15.h),
          Text(
            size,
            style: TextStyle(fontSize: 12.sp, color: tdGrey),
          ),
        ],
      ),
    );
  }
}
