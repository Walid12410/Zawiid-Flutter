import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/core/Color&Icons/color.dart';

class FeaturedProductCard extends StatelessWidget {
  const FeaturedProductCard({super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).w,
      child: IntrinsicWidth(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18).w,
              color: tdGreyHome1),
          child: Row(
            children: [
              SizedBox(width: 20.w),
              Padding(
                padding:const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10).w,
                child: SizedBox(
                    width: 90.w,
                    height: 80.h,
                    child: Image.asset(
                      'assets/img/camera.png',
                      fit: BoxFit.contain,
                    )),
              ),
              SizedBox(width: 15.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.h),
                  SizedBox(
                    width: 130.w,
                    child: RichText(
                      text: TextSpan(
                        text: 'CATCH BIG ',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: tdBlack,
                          fontWeight: FontWeight.w300
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'DEALS',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                              color: tdBlack,
                            ),
                          ),
                          TextSpan(
                            text: ' ON THE CAMERA',
                            style: TextStyle(
                              fontSize: 18.sp,
                              overflow: TextOverflow.ellipsis,
                              color: tdBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Shop now',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: tdBlack),
                  ),
                  SizedBox(height: 5.h,)
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
