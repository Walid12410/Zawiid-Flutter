import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Color&Icons/color.dart';

class AddressDetails extends StatelessWidget {
  const AddressDetails({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5).w,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: tdWhite,
          borderRadius: BorderRadius.circular(10).w,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(5,5),
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12).w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Home',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: tdBlack,
                        fontSize: 15.sp),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'PO Box 81731 J Hawally, Salwa',
                    style: TextStyle(
                        color: tdBlack, fontSize: 12.sp),
                  ),
                  Text(
                    'Block 4',
                    style: TextStyle(
                        color: tdBlack, fontSize: 12.sp),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    '+965 60378430',
                    style: TextStyle(
                        fontSize: 12.sp, color: tdBlack),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(5).w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        // button
                      },
                      child: Text(
                        'Use as default',
                        style: TextStyle(
                            fontSize: 15.h,
                            color: tdBlack,
                            fontWeight: FontWeight.bold),
                      )),
                  GestureDetector(
                      onTap: () {
                        //Delete address
                      },
                      child: Text(
                        'Delete',
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: tdGrey),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
