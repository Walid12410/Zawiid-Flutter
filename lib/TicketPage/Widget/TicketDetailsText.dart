import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/Color&Icons/color.dart';

class TicketDetailsText extends StatelessWidget {
  const TicketDetailsText({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Buy a 1\$ ticket and enter ',
            style: TextStyle(
              fontSize: 15.sp,
              color: tdGrey,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  'A withdrawal on a ',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: tdGrey,
                  ),
                ),
              ),
              Text(
                'WASHING-MACHINE!',
                style: TextStyle(
                  color: tdGrey,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      );
  }
}
