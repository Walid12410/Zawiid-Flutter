import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Color&Icons/color.dart';

class ServiceOptionCard extends StatelessWidget {
  const ServiceOptionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0).w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: tdWhite,
              borderRadius: BorderRadius.circular(20).w,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: const Offset(4.0, 4.0),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12).w,
              child: Column(
                children: [
                  SizedBox(height: 5.h),
                  SizedBox(
                    height: 52.h,
                    width: 71.w,
                    child: Image.asset(
                      'assets/img/CustomerService/mail.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 140.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20).w,
                          color: tdWhiteNav),
                      child: Center(
                        child: Text(
                          'Email Us',
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: tdBlack,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: tdWhite,
              borderRadius: BorderRadius.circular(20).w,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: const Offset(4.0, 4.0),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12).w,
              child: Column(
                children: [
                  SizedBox(height: 5.h),
                  SizedBox(
                    height: 54.h,
                    width: 74.w,
                    child: Image.asset(
                      'assets/img/CustomerService/speech.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 5.sp),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 140.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: tdWhiteNav),
                      child: Center(
                        child: Text(
                          'Chat Now',
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: tdBlack,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
