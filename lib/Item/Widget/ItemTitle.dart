import 'package:flutter/material.dart';

import '../../Color&Icons/color.dart';

class ItemTitle extends StatelessWidget {
  const ItemTitle({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('APPLE',style: TextStyle(fontSize: screenWidth * 0.05,fontWeight: FontWeight.bold,color: tdBlack),),
        Text('Apple iPhone 15 Pro Max 6.7- Inch 250GB',style: TextStyle(
            color: tdBlack,fontSize: screenWidth * 0.033
        ),),
        Text('White Titanium',style: TextStyle(fontSize: screenWidth * 0.033,color: tdBlack),),
      ],
    );
  }
}
