import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../Color&Icons/my_flutter_app_icons.dart';

class ProfileHeadPage extends StatelessWidget {
  const ProfileHeadPage({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 70).w,
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
          Icon(
            MyFlutterApp.group_168,
            size: 50.w,
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}
