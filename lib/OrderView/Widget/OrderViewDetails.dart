import 'package:flutter/material.dart';

import '../../Color&Icons/color.dart';


class OrderViewDetails extends StatelessWidget {
  const OrderViewDetails({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
                width: screenWidth * 0.30,
                height: screenHeight * 0.2,
                child: Image.asset('assets/img/iphone.png',fit: BoxFit.contain,)
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SAMSUNG Galaxy S24 Ultra',style: TextStyle(
                      fontSize: screenWidth * 0.033,fontWeight: FontWeight.bold,color: tdBlack
                  ),),
                  Padding(
                    padding: const EdgeInsets.only(right: 200),
                    child: Text('128GB RAM +ads sdss',style: TextStyle(fontWeight: FontWeight.bold,fontSize: screenWidth * 0.033),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,),
                  ),
                  SizedBox(height: screenHeight * 0.02,),
                  Text('358.000 KD',style: TextStyle(fontSize: screenWidth * 0.033,fontWeight: FontWeight.bold,color: tdGrey),),
                  SizedBox(height: screenHeight * 0.01,),
                  Text('SKU: FT00962',style: TextStyle(fontSize: screenWidth * 0.02,color: tdGrey),)
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
