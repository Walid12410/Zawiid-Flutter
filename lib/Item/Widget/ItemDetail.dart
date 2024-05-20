
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Color&Icons/color.dart';


class ItemDetail extends StatelessWidget {
  const ItemDetail({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Product Details',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold,color: tdBlack),),
        SizedBox(height: 20.h),
        Text('- Display: 6.7 inch Super Retina XDR OLED Display,2796x 1290 Pixels',style: TextStyle(
            color: tdBlack,fontSize: 12.sp
        ),),
        SizedBox(height: 10.h),
        Text('- Processor: a17 Pro chip',style: TextStyle(
            color: tdBlack,fontSize: 12.sp
        ),),
        SizedBox(height: 10.h),
        Text('- Memory: 256GB/8GB',style: TextStyle(
            color: tdBlack,fontSize: 12.sp
        ),),
        SizedBox(height: 10.h),
        Text('- Sensors: Face ID, LiDAR Scanner, Barometer, High dynamic Range gyro, High-g accelerometer, Proximity sensor, Dual Ambient light sensorts',style: TextStyle(
            color: tdBlack,fontSize: 12.sp
        ),),
        SizedBox(height: 10.h),
        Text('- Front Camera: 12MP (f/1.9)',style: TextStyle(
            color: tdBlack,fontSize: 12.sp
        ),),
        SizedBox(height: 10.h),
        Text('- CPU: New 6-core CPU with 2 performance and 4 efficiency cores',style: TextStyle(
            color: tdBlack,fontSize: 12.sp
        ),),

      ],
    );
  }
}
