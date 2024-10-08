import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/localization/generated/l10n.dart';
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
              height: 40.sp,
            ),
            Padding(
              padding: const EdgeInsets.all(8).w,
              child: Text(
                S.of(context).supportDetails,
                style: TextStyle(
                    color: tdBlack,
                    fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30.sp,
            ),
            const ServiceOptionCard(),
            SizedBox(height: 10.h),
            const ServiceCallUs()
          ],
        ),
      ),
    );
  }
}
