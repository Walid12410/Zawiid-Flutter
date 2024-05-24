import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Color&Icons/color.dart';


class OrderViewDetails extends StatelessWidget {
  const OrderViewDetails({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
                width: 90.w,
                height: 90.h,
                child: Image.asset('assets/img/iphone.png',fit: BoxFit.contain,)
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('SAMSUNG Galaxy S24 Ultra',style: TextStyle(
                        fontSize: 10.sp,fontWeight: FontWeight.bold,color: tdBlack
                    ),),
                  Padding(
                    padding: const EdgeInsets.only(right: 170).w,
                    child: Text('128GB RAM +ads sdss',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10.sp),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,),
                  ),
                  SizedBox(height: 15.h,),
                  Text('358.000 KD',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,color: tdGrey),),
                  SizedBox(height: 5.h,),
                  Text('SKU: FT00962',style: TextStyle(fontSize: 4.sp,color: tdGrey),)
                ],
              ),
            )
          ],
        ),
        const Divider(),
      ],
    );
  }
}
