import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/localization/generated/l10n.dart';

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

class TicketDetailsText extends StatelessWidget {
  const TicketDetailsText({super.key,required this.ticketPrice,required this.ticketTitle});

  final String ticketTitle;
  final String ticketPrice;
  @override
  Widget build(BuildContext context) {
    double price = double.parse(ticketPrice);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${S.of(context).buy} ${price.toStringAsFixed(2)}\$ ${S.of(context).ticketEnter}',
          style: TextStyle(
            fontSize: 12.sp,
            color: tdGrey,
            fontWeight: FontWeight.w400
          ),
        ),
        RichText(
          text: TextSpan(
            text: S.of(context).withDrawl,
            style: TextStyle(
              fontSize: 12.sp,
              color: tdGrey,
                fontWeight: FontWeight.w400
            ),
            children: [
              TextSpan(
                text: ticketTitle,
                style: TextStyle(
                  color: tdGrey, // Example: Change to your special color
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
