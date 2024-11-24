import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/generated/l10n.dart';

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

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
          borderRadius: BorderRadius.circular(15).w,
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
            S.of(context).details,
            style: TextStyle(fontSize: 12.sp, color: tdBlack),
          ),
        ),
      ),
    );
  }
}
