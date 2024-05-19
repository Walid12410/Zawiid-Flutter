import 'package:flutter/material.dart';

import '../../Color&Icons/color.dart';

class ItemShipping extends StatelessWidget {
  const ItemShipping({
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
        Text('Shipping',style: TextStyle(fontSize: screenWidth * 0.05,fontWeight: FontWeight.bold,color: tdBlack),),
        SizedBox(height: screenHeight * 0.02,),
        Text('Scheduled delivery (Free)',style: TextStyle(fontSize: screenWidth * 0.05,fontWeight: FontWeight.bold,color: tdBlack),),
        SizedBox(height: screenHeight * 0.01,),
        Text('Free Next-Day delivery',style: TextStyle(fontSize: screenWidth * 0.033,color: tdBlack),),
        SizedBox(height: screenHeight * 0.01,),
        Row(
          children: [
            Text('1-Hour Express Delivery Available',style: TextStyle(fontSize: screenWidth * 0.05,fontWeight: FontWeight.bold,color: tdBlack),),
            SizedBox(width: screenWidth * 0.01,),
            Text('(+1.500 KD)',style: TextStyle(fontSize: screenWidth * 0.020,color: tdGrey),),

          ],
        ),
        SizedBox(height: screenHeight * 0.01,),
        Text('Order now and get it within 1 hour',style: TextStyle(fontSize: screenWidth * 0.033,color: tdBlack),),
        SizedBox(height: screenHeight * 0.01,),
        Row(
          children: [
            Text('3-Hour Express Delivery Available',style: TextStyle(fontSize: screenWidth * 0.05,fontWeight: FontWeight.bold,color: tdBlack),),
            SizedBox(width: screenWidth * 0.01,),
            Text('(+1.000 KD)',style: TextStyle(fontSize: screenWidth * 0.020,color: tdGrey),),
          ],
        ),
      ],
    );
  }
}
