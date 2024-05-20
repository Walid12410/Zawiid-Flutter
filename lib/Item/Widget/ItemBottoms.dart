import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Color&Icons/color.dart';

class ItemBottoms extends StatelessWidget {
  const ItemBottoms({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: (){
            //ADD TO CART
          },
          child: Container(
            width: 220.w,
            height: 35.h,
            decoration: BoxDecoration(
                border: Border.all(color: tdBlack),
                borderRadius: BorderRadius.circular(20).w
            ),
            child: Center(
                child: Text('Add to cart',style: TextStyle(
                    color: tdBlack,fontWeight: FontWeight.bold,fontSize: 19.sp
                ),)),
          ),
        ),
        SizedBox(width: 10.w),
        GestureDetector(
          onTap: (){
            //Buy
          },
          child: Container(
            width: 110.w,
            height: 35.h,
            decoration: BoxDecoration(
                border: Border.all(color: tdBlack),
                borderRadius: BorderRadius.circular(20).w
            ),
            child: Center(
                child: Text('Buy',style: TextStyle(
                    color: tdBlack,fontWeight: FontWeight.bold,fontSize: 19.sp
                ),)),
          ),
        )
      ],
    );
  }
}
