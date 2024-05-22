import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Color&Icons/color.dart';

class ItemPrice extends StatelessWidget {
  const ItemPrice({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('522.42 LB',style: TextStyle(fontSize: 14.sp,color: tdBlack,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.lineThrough,
          decorationThickness: 2.5, // Adjust the thickness of the line through
          decorationColor: tdGrey,
        ),
        ),
        SizedBox(width: 15.w),
        Text('530.23 LB',style: TextStyle(fontSize: 20.sp,color: Colors.red,fontWeight: FontWeight.bold),)
      ],
    );
  }
}
