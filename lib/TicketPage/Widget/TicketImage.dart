import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TicketImage extends StatelessWidget {
  const TicketImage({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0).w,
      child: Container(
        width: double.infinity,
        height: 300.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20).w,
          image: const DecorationImage(
            image: AssetImage('assets/img/ticketTestingimage.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
