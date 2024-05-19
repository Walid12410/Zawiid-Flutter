import 'package:flutter/material.dart';

import '../../Color&Icons/color.dart';

class SearchHistoryCard extends StatelessWidget {
  const SearchHistoryCard({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.only(left:screenWidth * 0.03, right: screenWidth * 0.03 ,bottom: screenWidth * 0.03),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 5,
                spreadRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
            color: tdWhite
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenWidth * 0.07,
              height: screenHeight * 0.05,
              child: Image.asset('assets/img/iphone.png',fit: BoxFit.fill,),
            ),
            Padding(
              padding:  EdgeInsets.all(screenWidth * 0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Iphone 16 ProMax ',style: TextStyle(
                      fontSize: screenWidth * 0.025,color: tdGrey,fontWeight: FontWeight.bold),),
                  Text('110\$',style: TextStyle(color: tdGrey,fontSize: screenWidth * 0.025),)

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
