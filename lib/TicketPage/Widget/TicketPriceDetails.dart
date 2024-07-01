import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/Color&Icons/color.dart';

class TicketPriceDetails extends StatelessWidget {
  const TicketPriceDetails({
    super.key,required this.ticketPrice
  });


  final String ticketPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      height: 30.h,
      decoration: BoxDecoration(
        color: tdWhite,
        borderRadius: BorderRadius.circular(50).w,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(0, 0),
            blurRadius: 5,
          ),
        ],
      ),
      child:  Center(
        child: Text('$ticketPrice\$ TICKET',style: TextStyle(color: tdGrey,fontSize: 14.sp,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
