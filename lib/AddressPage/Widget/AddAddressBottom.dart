import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Color&Icons/color.dart';

class AddAddressBottom extends StatelessWidget {
  const AddAddressBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20).w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            Icons.add_circle_outline,
            size: 15.w,
          ),
          Text(
            'ADD ADDRESS',
            style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: tdGrey),
          )
        ],
      ),
    );
  }
}
