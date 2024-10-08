import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Api/NotificationService.dart';
import 'package:zawiid/Widget/Header.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/localization/generated/l10n.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import 'package:zawiid/provider/NotificationProvider.dart';
import '../AccountInfoPage/Details/GuestView.dart';
import 'Details/NotificationContainer.dart';

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
                S.of(context).areYouSure,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                S.of(context).toClearNotify,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: tdBlack,
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
                      NotificationService2 service =  NotificationService2();
                      notificationProvider.clearCart();
                      Navigator.of(context).pop();
                      service.deleteAllNotifications(userID);
                    },
                    child: Container(
                      width: 100.w,
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: tdWhite,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          S.of(context).yes,
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
                          S.of(context).no,
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: tdWhite,
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
                    PageHeadView(title: S.of(context).notification, onPressed: (){
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
                                  S.of(context).clearNotify,
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
                                S.of(context).nothingToShow,
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
                  PageHeadView(title: S.of(context).notification, onPressed: (){
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
