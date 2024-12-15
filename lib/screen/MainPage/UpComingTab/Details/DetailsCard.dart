import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Widget/SnackBar.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/core/LocalNotification.dart';
import 'package:zawiid/core/TimeMethod/CheckWhatDate.dart';
import 'package:zawiid/core/config.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:zawiid/model/Bid/bidProduct.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import '../../WatchDown/WatchCount.dart';

class UpComingCard extends StatefulWidget {
  const UpComingCard({
    Key? key,
    required this.bid
  }) : super(key: key);

  final BidProduct bid;

  @override
  _UpComingCardState createState() => _UpComingCardState();
}

class _UpComingCardState extends State<UpComingCard> {
  late Timer _timer;
  bool _hasStarted = false;
  bool _hasEnded = false;
  late DateTime _countdownEndTime;
  bool _isNotified = false;

  @override
  void initState() {
    super.initState();
    _updateTimeConditions();
    _checkIfNotified();
    _timer = Timer.periodic(
        const Duration(seconds: 1), (_) => _updateTimeConditions());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTimeConditions() {
    DateTime now = DateTime.now();
    bool hasStarted = now.isAfter(widget.bid.bidStartDate);
    bool hasEnded = now.isAfter(widget.bid.bidEndDate);
    setState(() {
      _hasStarted = hasStarted;
      _hasEnded = hasEnded;
      _countdownEndTime = _hasStarted ? widget.bid.bidEndDate : widget.bid.bidStartDate;
    });
  }

  void _checkIfNotified() async {
    final notificationService = Provider.of<NotificationService>(context, listen: false);
    _isNotified = await notificationService.isNotificationScheduled(widget.bid.bidNo);
    setState(() {});
  }

  void _handleNotifyMe() async {
    final notificationService = Provider.of<NotificationService>(context, listen: false);
    final auth = Provider.of<AuthProvider>(context, listen: false);

    if (auth.userId == 0) {
      showSnackBar(context,  S.of(context).loginError);
      return;
    }

    if (_isNotified) {
      await notificationService.cancelNotification(widget.bid.bidNo);
      setState(() {
        showSnackBar(context,  S.of(context).notificationCancel);
      });
    } else {
      // Schedule the notification
      await notificationService.scheduleNotification(
        id: widget.bid.bidNo,
        title: S.of(context).bidStart,
        body: '${S.of(context).bidFor} ${widget.bid.productName} ${S.of(context).startAt} ${DateFormat('hh:mm a').format(widget.bid.bidStartDate)}',
        scheduledTime: widget.bid.bidStartDate,
      );
      setState(() {
        showSnackBar(context, S.of(context).notificationScheduled);
      });
    }
    _checkIfNotified();
  }

  @override
  Widget build(BuildContext context) {
    String formattedStartTime = DateFormat('d MMMM, hh:mm a').format(widget.bid.bidStartDate);
    String dateCategory = getDateCategory(context, widget.bid.bidStartDate);
    AuthProvider auth  = Provider.of<AuthProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(8.0).w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20).w,
            child: SizedBox(
              width: double.infinity,
              height: 210.h,
              child: CachedNetworkImage(
                imageUrl: '${ApiEndpoints.localBaseUrl}/${widget.bid.productImage}',
                placeholder: (context, url) =>
                    Image.asset('assets/log/LOGO-icon---Black.png'),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/log/LOGO-icon---Black.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            '${widget.bid.productName} / ${widget.bid.colorName}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
              color: tdBlack,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                formattedStartTime,
                style: TextStyle(fontSize: 8.sp, color: tdGrey),
              ),
              Text(
                " $dateCategory",
                style: TextStyle(fontSize: 8.sp, color: tdGreen),
              )
            ],
          ),
          Text(
            '${S.of(context).startPrice} ${widget.bid.startPrice}\$',
            style: TextStyle(fontSize: 8.sp, color: tdGrey),
          ),
          SizedBox(height: 10.h),
          _hasEnded
              ? Container(
                  width: 180.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20).w,
                    border: Border.all(color: tdBlack),
                  ),
                  child: Center(
                    child: Text(
                      S.of(context).bidEnded,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: tdBlack,
                      ),
                    ),
                  ),
                )
              : _hasStarted
                  ? GestureDetector(
                      onTap: () {
                        if(auth.userId == 0){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                S.of(context).loginError,
                                style: TextStyle(fontSize: 10.sp, color: tdWhite),
                              ),
                              backgroundColor: tdBlack,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                          return;
                        }
                        GoRouter.of(context).goNamed('BidPage',
                        pathParameters: {'bidNo' : widget.bid.bidNo.toString(),
                          'productNo' : widget.bid.productNo.toString(),
                          'colorNo' : widget.bid.colorNo.toString()
                        });
                      },
                      child: Container(
                        width: 180.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20).w,
                          border: Border.all(color: tdBlack),
                        ),
                        child: Center(
                          child: Text(
                            S.of(context).zawiid,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: tdBlack,
                            ),
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: _handleNotifyMe,
                      child: Container(
                        width: 180.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20).w,
                          border: Border.all(color: tdBlack),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              _isNotified
                                  ? Icons.notifications_off_outlined
                                  : Icons.notifications_active_outlined,
                              color: tdBlack,
                              size: 15.w,
                            ),
                            Text(
                              _isNotified ? S.of(context).cancelNotify : S.of(context).notifyMe,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: tdBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
          SizedBox(height: 5.h),
          CountdownTimerScreen(endTime: _countdownEndTime),
        ],
      ),
    );
  }
}
