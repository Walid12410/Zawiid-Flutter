import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:zawiid/core/Color&Icons/color.dart';

class NotificationContainer extends StatelessWidget {
  final String title;
  final String message;
  final DateTime date;

  const NotificationContainer({
    super.key,
    required this.title,
    required this.message,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8).w,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15).w,
          color: tdWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0).w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 12.sp, fontWeight: FontWeight.bold, color: tdBlack),
              ),
              Text(
                message,
                style: TextStyle(fontSize: 10.sp, color: tdBlack),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    formatDateTime(date),
                    style: TextStyle(fontSize: 8.sp, color: tdBlack),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDateTime(DateTime date) {
    final DateFormat dateFormatter = DateFormat('d MMM yyyy');
    final DateFormat timeFormatter = DateFormat('h:mm a');
    return '${dateFormatter.format(date)} . ${timeFormatter.format(date)}';
  }
}
