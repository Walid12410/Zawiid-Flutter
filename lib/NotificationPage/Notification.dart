import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/ApiService/NotificationService/DeleteAllNotification.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:zawiid/Widget/PageHeadWidget.dart';
import 'package:zawiid/provider/Auth_Provider.dart';

import '../AccountInfoScreen/Widget/GuestView.dart';
import '../provider/NotificationProvider.dart';
import 'Widget/NotificationContainer.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  void _showClearNotificationDialog(BuildContext context, int userID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final notificationProvider =
            Provider.of<NotificationsProvider>(context, listen: false);
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          backgroundColor: tdWhite,
          surfaceTintColor: tdWhite,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Are you sure you want',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'to clear all notification',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      notificationProvider.clearCart();
                      Navigator.of(context).pop();
                      deleteAllNotifications(userID);
                    },
                    child: Container(
                      width: 100.w,
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'YES',
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: tdBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 100.w,
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: tdBlack,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'NO',
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final notificationProvider =
        Provider.of<NotificationsProvider>(context, listen: true);
    var allNotification = notificationProvider.allNotification;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Convert the list of notifications into a list of widgets
    List<Widget> notificationWidgets = [];
    for (var notification in allNotification) {
      notificationWidgets.add(
        NotificationContainer(
          title: notification.notificationTitle,
          message: notification.notificationMessage,
          date: notification.sentAt,
        ),
      );
    }

    return authProvider.userId != 0
        ? Scaffold(
            backgroundColor: tdWhite,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    PageHeadView(title: 'Notification', onPressed: (){
                      GoRouter.of(context).go("/home");
                    }),
                    Padding(
                      padding: const EdgeInsets.all(8.0).w,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (authProvider.userId == 0) {
                                    null;
                                  } else if (allNotification.isEmpty) {
                                    null;
                                  } else {
                                    _showClearNotificationDialog(
                                        context, authProvider.userId);
                                  }
                                },
                                child: Text(
                                  'Clear notifications',
                                  style:
                                      TextStyle(fontSize: 10.sp, color: tdGrey),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10.h),
                          // Display a message if there are no notifications
                          if (allNotification.isEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 200).w,
                              child: Text(
                                'Nothing to show',
                                style:
                                    TextStyle(fontSize: 12.sp, color: tdGrey),
                                textAlign: TextAlign.center,
                              ),
                            )
                          else
                            Column(
                              children: notificationWidgets,
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: tdWhite,
            body: SafeArea(
              child: Column(
                children: [
                  PageHeadView(title: 'Notification', onPressed: (){
                    GoRouter.of(context).go("/home");
                  }),
                  SizedBox(
                    height: 180.h,
                  ),
                  const GuestViewProfile()
                ],
              ),
            ),
          );
  }
}
