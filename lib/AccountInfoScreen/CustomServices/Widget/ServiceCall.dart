import 'package:flutter/material.dart';

import '../../../Color&Icons/color.dart';


class ServiceCallUs extends StatelessWidget {
  const ServiceCallUs({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: tdWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(4.0, 4.0),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: screenHeight * 0.05,
                child: Image.asset('assets/img/CustomerService/Group.png',fit: BoxFit.contain,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  //calluse
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: tdWhiteNav,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(width: screenWidth * 0.02,),
                        Text('Call Us',style: TextStyle(fontWeight: FontWeight.bold,fontSize: screenWidth * 0.05,color: tdBlack),),
                        SizedBox(width: screenWidth * 0.07,),
                        Text('+965 6037 8430',style: TextStyle(color: tdBlue,fontSize:  screenWidth * 0.05,fontWeight: FontWeight.bold),),
                        SizedBox(width: screenWidth * 0.02,),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
