import 'package:flutter/material.dart';

import '../../../Color&Icons/color.dart';

class SoldDetails extends StatelessWidget {
  const SoldDetails({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: screenHeight * 0.4,
            child: Image.asset(
              'assets/img/iphone.png',
              fit: BoxFit.contain,
            ),
          ),
          const Text(
            'iPhone 14 ProMax / 256GB Black Color',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: tdBlack),
          ),
          SizedBox(height: screenHeight * 0.02,),
          const Text('30th April. 10.00PM',style: TextStyle(fontSize: 15,color: tdGrey),),
          const Text('SOLD AT: 1550KD',style: TextStyle(fontSize: 15,color: tdGrey),),
          SizedBox(height: screenHeight * 0.02),
          Container(
            width: screenWidth * 0.65,
            height: screenHeight * 0.04,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: tdBlack)
            ),
            child: const Center(
              child: Text('SOLD',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: tdBlack),),
            ),
          ),

        ],
      ),);
  }
}
