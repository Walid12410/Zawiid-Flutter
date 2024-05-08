import 'package:flutter/material.dart';
import '../../Color&Icons/color.dart';

class TicketDetailsBottom extends StatelessWidget {
  const TicketDetailsBottom({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.onTap,
  });

  final double screenWidth;
  final double screenHeight;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.4,
        height: screenHeight * 0.04,
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
        child:  Center(
          child: Text(
            'Details',
            style: TextStyle(fontSize: screenWidth * 0.04, color: tdBlack),
          ),
        ),
      ),
    );
  }
}
