import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Color&Icons/color.dart';

class ItemTitle extends StatelessWidget {
  const ItemTitle({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('APPLE',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold,color: tdBlack),),
        Text('Apple iPhone 15 Pro Max 6.7- Inch 250GB',style: TextStyle(
            color: tdBlack,fontSize: 15.sp
        ),),
        Text('White Titanium',style: TextStyle(fontSize: 15.sp,color: tdBlack),),
      ],
    );
  }
}
