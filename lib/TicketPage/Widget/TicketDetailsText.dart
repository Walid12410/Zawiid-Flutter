import 'package:flutter/material.dart';
import 'package:zawiid/Color&Icons/color.dart';

class TicketDetailsText extends StatelessWidget {
  const TicketDetailsText({
    super.key,
    required this.screenWidth,
    required this.screenHeight
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Buy a 1\$ ticket and enter ',
            style: TextStyle(
              fontSize: screenWidth * 0.037,
              color: tdGrey,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  'A withdrawal on a ',
                  style: TextStyle(
                    fontSize: screenWidth * 0.037,
                    color: tdGrey,
                  ),
                ),
              ),
              Text(
                'WASHING-MACHINE!',
                style: TextStyle(
                  color: tdGrey,
                  fontSize: screenWidth * 0.037,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
