import 'package:flutter/material.dart';

import '../../Color&Icons/color.dart';

class AddAddressBottom extends StatelessWidget {
  const AddAddressBottom({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            Icons.add_circle_outline,
            size: screenWidth * 0.05,
          ),
          Text(
            'ADD ADDRESS',
            style: TextStyle(
                fontSize: screenWidth * 0.030,
                fontWeight: FontWeight.bold,
                color: tdBlack),
          )
        ],
      ),
    );
  }
}
