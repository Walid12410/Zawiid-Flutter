import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Color&Icons/color.dart';


class BidPageBottom extends StatelessWidget {
  const BidPageBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 30.h,
        width: 250.w,
        decoration: BoxDecoration(
          color: tdBlack,
          borderRadius: BorderRadius.circular(15).w,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 0),

            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 160.w,
              decoration: BoxDecoration(
                color: tdWhite,
                borderRadius: BorderRadius.circular(15).w,
              ),
              child: Center(
                child: Text('\$200',style: TextStyle(fontSize: 8.sp,color: tdGrey),),
              ),
            ),
            Container(
              width: 80.w,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15)
                ).w,
                color: tdBlack,
              ),
              child: Center(
                child: Text('Bid Now',style: TextStyle(fontSize: 8.sp,color: tdWhite),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
