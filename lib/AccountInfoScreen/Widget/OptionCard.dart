import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Color&Icons/color.dart';

class OptionsCard extends StatelessWidget {
  const OptionsCard(
      {super.key,
      required this.icon1,
      required this.text1,
      required this.icon2,
      required this.text2,
      required this.onTap1,
      required this.onTap2,
      required this.isWhatsapp});

  final String icon1;
  final String icon2;
  final String text1;
  final String text2;
  final VoidCallback onTap1;
  final VoidCallback onTap2;
  final bool isWhatsapp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0.w),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10).w,
          color: tdWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: onTap1,
              child: Padding(
                padding: const EdgeInsets.only(
                        top: 8, right: 12, left: 12, bottom: 4)
                    .w,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      icon1,
                      width: 18.sp,
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: Text(
                        text1,
                        style: TextStyle(color: tdGrey, fontSize: 14.sp),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 5.h,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50).w,
                          ),
                          width: 23.w,
                          height: 22.h,
                          child: SvgPicture.asset(
                            'assets/svg/arrow.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 15.w),
              child: const Divider(
                color: tdGrey,
                thickness: 0.2,
              ),
            ),
            GestureDetector(
              onTap: onTap2,
              child: Padding(
                padding: const EdgeInsets.only(
                        top: 4, right: 12, left: 12, bottom: 8)
                    .w,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      icon2,
                      width: 18.sp,
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: Text(
                        text2,
                        style: TextStyle(
                          color: tdGrey,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    isWhatsapp
                        ? Column(
                          children: [
                            SizedBox(height: 5.h,),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50).w,
                                ),
                                width: 25.w,
                                height: 22.h,
                                child: SvgPicture.asset(
                                  'assets/svg-profile/whatsapp.svg',
                                  color: tdGreen,
                                  fit: BoxFit.fill,
                                ),
                              ),
                          ],
                        )
                        : Column(
                          children: [
                            SizedBox(height: 5.h,),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50).w,
                              ),
                              width: 23.w,
                              height: 22.h,
                              child: SvgPicture.asset(
                                'assets/svg/arrow.svg',
                                fit: BoxFit.contain
                              ),
                            ),
                          ],
                        )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
