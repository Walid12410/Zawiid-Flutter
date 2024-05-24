import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Color&Icons/color.dart';

class TicketDetailsBottom extends StatelessWidget {
  const TicketDetailsBottom({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120.w,
        height: 25.h,
        decoration: BoxDecoration(
          color: tdWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(0, 0),
              blurRadius: 5,
            ),
          ],
        ),
        child:  Center(
          child: Text(
            'Details',
            style: TextStyle(fontSize: 12.sp, color: tdBlack),
          ),
        ),
      ),
    );
  }
}
