import 'package:flutter/material.dart';

import '../../Color&Icons/color.dart';

class ItemPrice extends StatelessWidget {
  const ItemPrice({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('522.42 LB',style: TextStyle(fontSize: screenWidth * 0.04,color: tdBlack,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.lineThrough,
          decorationThickness: 2.5, // Adjust the thickness of the line through
          decorationColor: tdGrey,
        ),
        ),
        SizedBox(width: screenWidth * 0.05,),
        Text('530.23 LB',style: TextStyle(fontSize: screenWidth * 0.06,color: Colors.red,fontWeight: FontWeight.bold),)
      ],
    );
  }
}
