import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/Color&Icons/color.dart';

class TicketPriceDetails extends StatelessWidget {
  const TicketPriceDetails({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      height: 35.h,
      decoration: BoxDecoration(
        color: tdWhite,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(4.0, 4.0),
            blurRadius: 15,
          ),
        ],
      ),
      child:  Center(
        child: Text('1\$ TICKET',style: TextStyle(color: tdGrey,fontSize: 15.sp,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
