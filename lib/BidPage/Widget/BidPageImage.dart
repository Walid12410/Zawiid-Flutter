import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Color&Icons/color.dart';

class BidPageImage extends StatelessWidget {
  const BidPageImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: double.infinity,
        height: 230.h,
        decoration: BoxDecoration(
          color: tdWhite,
          borderRadius: BorderRadius.circular(15).w,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Center(
            child: Image.asset(
              'assets/img/iphone.png',
              fit: BoxFit.contain,
            )),
      );
  }
}
