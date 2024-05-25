import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SecondOpeningImage extends StatelessWidget {
  const SecondOpeningImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10).w,
      child: Container(
          width: double.infinity,
          height: 110.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20).w),
          child: Image.asset(
            'assets/img/sddefault.png',
            fit: BoxFit.fill,
          )),
    );
  }
}
