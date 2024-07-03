import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/Color&Icons/color.dart';

class TicketDetailsText extends StatelessWidget {
  const TicketDetailsText({super.key,required this.ticketPrice});

  final String ticketPrice;
  @override
  Widget build(BuildContext context) {
    double price = double.parse(ticketPrice);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Buy a ${price.toStringAsFixed(2)}KD ticket and enter',
          style: TextStyle(
            fontSize: 12.sp,
            color: tdGrey,
            fontWeight: FontWeight.w400
          ),
        ),
        RichText(
          text: TextSpan(
            text: 'A withdrawal on a ',
            style: TextStyle(
              fontSize: 12.sp,
              color: tdGrey,
                fontWeight: FontWeight.w400
            ),
            children: [
              TextSpan(
                text: 'WASHING-MACHINE!',
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
