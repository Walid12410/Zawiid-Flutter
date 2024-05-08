import 'package:flutter/material.dart';
import 'package:zawiid/Color&Icons/color.dart';

class TicketDetails extends StatelessWidget {
  const TicketDetails({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.onTap,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 30, left: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: screenWidth * 0.03,
                ),
                Text(
                  'SAMSUNG',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: tdBlack,
                    fontSize: screenWidth * 0.06,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset('assets/img/pop.png'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            'iPhone 12 ProMax 256GB',
            style: TextStyle(fontSize: screenWidth * 0.033, color: tdGrey),
          ),
          Text(
            'Black Color',
            style: TextStyle(fontSize: screenWidth * 0.033, color: tdGrey),
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            'Black Color',
            style: TextStyle(fontSize: screenWidth * 0.033, color: tdGrey),
          ),
          Text(
            'No Scratches',
            style: TextStyle(fontSize: screenWidth * 0.033, color: tdGrey),
          ),
          Text(
            '1 Month Gurantee',
            style: TextStyle(fontSize: screenWidth * 0.033, color: tdGrey),
          ),
        ],
      ),
    );
  }
}
