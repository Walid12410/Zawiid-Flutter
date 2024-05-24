import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Color&Icons/color.dart';
import 'ServiceCall.dart';
import 'ServiceOptionalCard.dart';

class OptionContainer extends StatelessWidget {
  const OptionContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        color: tdWhite,
        borderRadius: BorderRadius.only(
          topLeft:const Radius.circular(30).w,
          topRight:const Radius.circular(30).w,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0).w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.sp,
            ),
            Padding(
              padding: const EdgeInsets.all(8).w,
              child: Text(
                'We’re here to help you at every step. Please look Through the options below and select what you’re looking for.',
                style: TextStyle(
                    color: tdBlack,
                    fontSize: 13.sp),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 50.sp,
            ),
            const ServiceOptionCard(),
            const ServiceCallUs()
          ],
        ),
      ),
    );
  }
}
