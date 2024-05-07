import 'package:flutter/material.dart';


class TicketImage extends StatelessWidget {
  const TicketImage({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: double.infinity,
        height: screenHeight * 0.48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
            image: AssetImage('assets/img/ticketTestingimage.png'),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
