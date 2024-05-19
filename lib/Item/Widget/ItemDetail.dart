
import 'package:flutter/material.dart';

import '../../Color&Icons/color.dart';


class ItemDetail extends StatelessWidget {
  const ItemDetail({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Product Details',style: TextStyle(fontSize: screenWidth * 0.05,fontWeight: FontWeight.bold,color: tdBlack),),
        SizedBox(height: screenHeight * 0.02,),
        Text('- Display: 6.7 inch Super Retina XDR OLED Display,2796x 1290 Pixels',style: TextStyle(
            color: tdBlack,fontSize: screenWidth * 0.033
        ),),
        SizedBox(height: screenHeight * 0.02,),
        Text('- Processor: a17 Pro chip',style: TextStyle(
            color: tdBlack,fontSize: screenWidth * 0.033
        ),),
        SizedBox(height: screenHeight * 0.02,),
        Text('- Memory: 256GB/8GB',style: TextStyle(
            color: tdBlack,fontSize: screenWidth * 0.033
        ),),
        SizedBox(height: screenHeight * 0.02,),
        Text('- Sensors: Face ID, LiDAR Scanner, Barometer, High dynamic Range gyro, High-g accelerometer, Proximity sensor, Dual Ambient light sensorts',style: TextStyle(
            color: tdBlack,fontSize: screenWidth * 0.033
        ),),
        SizedBox(height: screenHeight * 0.02,),
        Text('- Front Camera: 12MP (f/1.9)',style: TextStyle(
            color: tdBlack,fontSize: screenWidth * 0.033
        ),),
        SizedBox(height: screenHeight * 0.02,),
        Text('- CPU: New 6-core CPU with 2 performance and 4 efficiency cores',style: TextStyle(
            color: tdBlack,fontSize: screenWidth * 0.033
        ),),

      ],
    );
  }
}
