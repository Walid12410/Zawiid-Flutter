import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/Color&Icons/color.dart';

import 'Widget/NotificationContainer.dart';
import 'Widget/NotificationHead.dart';


class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const NotificationHead(),
              Padding(
                padding: const EdgeInsets.all(8.0).w,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Clear notifications',style: TextStyle(fontSize: 12.sp,color: tdGrey),)
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    const NotificationContainer(),
                    const NotificationContainer(),
                    const NotificationContainer(),
                    const NotificationContainer(),
                    const NotificationContainer(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


