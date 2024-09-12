import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}


class ProfileHeadPage extends StatelessWidget {
  const ProfileHeadPage({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:isArabic()? const EdgeInsets.only(right: 18, left: 45).w:
      const EdgeInsets.only(left: 18, right: 45).w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              GoRouter.of(context).go('/home');
            },
            child: SizedBox(
              width: 23.w,
              height: 70.h,
              child: Image.asset(
                'assets/img/pop.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            width: 100.w,
            height: 50.h,
            child: Image.asset(
              'assets/log/LOGO-icon---Black.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}
