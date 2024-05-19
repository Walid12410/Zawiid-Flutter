import 'package:flutter/material.dart';

import '../../Color&Icons/color.dart';

class ItemBottoms extends StatelessWidget {
  const ItemBottoms({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: (){
            //ADD TO CART
          },
          child: Container(
            width: screenWidth * 0.6,
            height: screenHeight * 0.04,
            decoration: BoxDecoration(
                border: Border.all(color: tdBlack),
                borderRadius: BorderRadius.circular(20)
            ),
            child: Center(
                child: Text('Add to cart',style: TextStyle(
                    color: tdBlack,fontWeight: FontWeight.bold,fontSize: screenWidth * 0.05
                ),)),
          ),
        ),
        GestureDetector(
          onTap: (){
            //Buy
          },
          child: Container(
            width: screenWidth * 0.3,
            height: screenHeight * 0.04,
            decoration: BoxDecoration(
                border: Border.all(color: tdBlack),
                borderRadius: BorderRadius.circular(20)
            ),
            child: Center(
                child: Text('Buy',style: TextStyle(
                    color: tdBlack,fontWeight: FontWeight.bold,fontSize: screenWidth * 0.05
                ),)),
          ),
        )
      ],
    );
  }
}
