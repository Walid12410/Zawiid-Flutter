import 'package:flutter/material.dart';
import '../../../Color&Icons/color.dart';
import '../../WatchDown/WatchCount.dart';

class DetailsUpComing extends StatelessWidget {
  const DetailsUpComing({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.endTime,
  });

  final double screenHeight;
  final double screenWidth;
  final DateTime endTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: screenHeight * 0.4,
            child: Image.asset(
              'assets/img/iphone.png',
              fit: BoxFit.contain,
            ),
          ),
           Text(
            'iPhone 14 ProMax / 256GB Black Color',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.04,
                color: tdBlack),
          ),
          SizedBox(height: screenHeight * 0.02,),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('30th April. 10.00PM',style: TextStyle(fontSize: screenWidth * 0.034,color: tdGrey),),
              Text(' Today',style: TextStyle(fontSize: screenWidth * 0.034,color: tdGreen),)
            ],
          ),
          Text('Starting Price: 50KD',style: TextStyle(fontSize: screenWidth * 0.034,color: tdGrey),),
          SizedBox(height: screenHeight * 0.02),
          Container(
            width: screenWidth * 0.65,
            height: screenHeight * 0.04,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: tdBlack)
            ),
            child:  Center(
              child: Text('Zawiiidddd',style: TextStyle(fontSize: screenWidth * 0.033,fontWeight: FontWeight.bold,color: tdBlack),),
            ),
          ),
          CountdownTimerScreen(endTime: endTime),
        ],
      ),
    );
  }
}
