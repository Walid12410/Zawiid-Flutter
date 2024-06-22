import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Color&Icons/color.dart';

import '../../provider/Auth_Provider.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: true);

    return GestureDetector(
      onTap: () {
        authProvider.logout();
        GoRouter.of(context).goNamed('SignIn');
      },
      child: Container(
        width: 100.w,
        height: 20.h,
        decoration: BoxDecoration(
            border: Border.all(color: tdGrey),
            borderRadius: BorderRadius.circular(15).w),
        child: Center(
          child: Text(
            'LOG OUT',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 9.sp,
                color: tdGrey),
          ),
        ),
      ),
    );
  }
}
