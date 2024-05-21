import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Color&Icons/color.dart';


class UserProfileCard extends StatelessWidget {
  const UserProfileCard({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15,left: 8).w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Walid Jallad',
                style: TextStyle(
                    color: tdGrey,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'wjallad55@gmail.com',
                style: TextStyle(fontSize: 13.sp, color: tdGrey,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.h),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 100.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: tdGrey),
                      borderRadius: BorderRadius.circular(20).w),
                  child: Center(
                    child: Text(
                      'EDIT PROFILE',
                      style:
                      TextStyle(fontSize: 10.sp, color: tdGrey),
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
                    fit: BoxFit.fill,
                  )),
              SizedBox(height: 7.h,)
            ],
          )
        ],
      ),
    );
  }
}
