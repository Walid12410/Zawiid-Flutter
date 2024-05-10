import 'package:flutter/material.dart';

import '../../Color&Icons/color.dart';

class AddressDetails extends StatelessWidget {
  const AddressDetails({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: tdWhite,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(5,5),
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Home',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: tdBlack,
                        fontSize: screenWidth * 0.05),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    'PO Box 81731 J Hawally, Salwa',
                    style: TextStyle(
                        color: tdBlack, fontSize: screenWidth * 0.033),
                  ),
                  Text(
                    'Block 4',
                    style: TextStyle(
                        color: tdBlack, fontSize: screenWidth * 0.033),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    '+965 60378430',
                    style: TextStyle(
                        fontSize: screenWidth * 0.033, color: tdBlack),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        // button
                      },
                      child: Text(
                        'Use as default',
                        style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: tdBlack,
                            fontWeight: FontWeight.bold),
                      )),
                  GestureDetector(
                      onTap: () {
                        //Delete address
                      },
                      child: Text(
                        'Delete',
                        style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: tdGrey),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
