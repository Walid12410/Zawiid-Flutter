import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpeningImage extends StatelessWidget {
  const OpeningImage({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 200.h,
        child: Image.asset(
          'assets/img/watch.png',
          fit: BoxFit.fill,
        ));
  }
}
