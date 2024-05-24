import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/Color&Icons/color.dart';

class TicketDetails extends StatelessWidget {
  const TicketDetails({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:const EdgeInsets.only(right: 30, left: 50).w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 3.w,
                ),
                Text(
                  'SAMSUNG',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: tdBlack,
                    fontSize: 18.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                GestureDetector(
                  onTap: onTap,
                  child: SizedBox(
                    width: 20.w,
                    height: 18.h,
                    child: Image.asset('assets/img/pop.png',fit: BoxFit.fill,),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            'iPhone 12 ProMax 256GB',
            style: TextStyle(fontSize: 12.sp, color: tdGrey),
          ),
          Text(
            'Black Color',
            style: TextStyle(fontSize: 12.sp, color: tdGrey),
          ),
          SizedBox(height: 10.h),
          Text(
            'Black Color',
            style: TextStyle(fontSize: 12.sp, color: tdGrey),
          ),
          Text(
            'No Scratches',
            style: TextStyle(fontSize: 12.sp, color: tdGrey),
          ),
          Text(
            '1 Month Gurantee',
            style: TextStyle(fontSize: 12.sp, color: tdGrey),
          ),
        ],
      ),
    );
  }
}
