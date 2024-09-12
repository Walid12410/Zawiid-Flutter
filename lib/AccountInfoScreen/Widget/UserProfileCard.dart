import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../Color&Icons/color.dart';
import '../../provider/User_Provider.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:intl/intl.dart';

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}


class UserProfileCard extends StatelessWidget {
  const UserProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserProvider userDetails = Provider.of<UserProvider>(context, listen: true);
    var userInfo = userDetails.userInfo;

    return Padding(
      padding:isArabic()? const EdgeInsets.only(left: 15, right: 8).w :
      const EdgeInsets.only(right: 15, left: 8).w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userInfo[0].firstName.isNotEmpty
                  ? Text(
                      '${userInfo[0].firstName} ${userInfo[0].lastName}',
                      style: TextStyle(
                          color: tdGrey,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    )
                  : const Text(''),
              userInfo[0].email.isNotEmpty
                  ? Text(
                      userInfo[0].email,
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: tdGrey,
                          fontWeight: FontWeight.bold),
                    )
                  : const Text(''),
              SizedBox(height: 5.h),
              GestureDetector(
                onTap: () {
                  context.goNamed("UpdateProfile");
                },
                child: Container(
                  width: 100.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: tdGrey),
                      borderRadius: BorderRadius.circular(15).w),
                  child: Center(
                    child: Text(
                     S.of(context).editProfile,
                      style: TextStyle(
                          fontSize: 9.sp,
                          color: tdGrey,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: 70.w,
                  height: 60.h,
                  child: Image.asset(
                    'assets/img/User.png',
                    fit: BoxFit.contain,
                  )),
              SizedBox(
                height: 7.h,
              )
            ],
          )
        ],
      ),
    );
  }
}
