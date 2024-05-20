import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Color&Icons/color.dart';

class FeaturedProductCard extends StatelessWidget {
  const FeaturedProductCard({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).w,
      child: IntrinsicWidth(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12).w,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                ),
              ],
              color: tdWhiteNav),
          child: Row(
            children: [
              SizedBox(width: 10.w),
              Padding(
                padding:const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10).w,
                child: SizedBox(
                    width: 80.w,
                    height: 70.h,
                    child: Image.asset(
                      'assets/img/camera.png',
                      fit: BoxFit.fill,
                    )),
              ),
              SizedBox(width: 10.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CATCH BIG',
                    style:
                    TextStyle(color: tdBlack, fontSize: 20.sp),
                  ),
                  Row(
                    children: [
                      Text(
                        'DEALS ',
                        style: TextStyle(
                            color: tdBlack,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'ON THE',
                        style: TextStyle(
                            color: tdBlack, fontSize: 20.sp),
                      )
                    ],
                  ),
                  Text(
                    'CAMERAS',
                    style:
                    TextStyle(fontSize:20.sp, color: tdBlack),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'Shop now',
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: tdBlack),
                  )
                ],
              ),
              SizedBox(
                width: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
