import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Color&Icons/color.dart';

class ViewChatContainer extends StatelessWidget {
  const ViewChatContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).w,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12).w,
            color: tdWhiteNav
        ),
        child: Padding(
          padding: const EdgeInsets.all(5).w,
          child: Row(
            children: [
              Icon(Icons.support_agent,size: 30.w,color: tdBlack,),
              SizedBox(width: 5.w,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bid Win error',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black, // Replace with `tdBlack` if defined
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '1 Aug 2024, 6:07 PM',
                          style: TextStyle(
                            fontSize: 8.sp,
                            color: Colors.black, // Replace with `tdBlack` if defined
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h), // Optional space between rows
                    Text(
                      ' adsad ad asd a',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.black, // Replace with `tdBlack` if defined
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
