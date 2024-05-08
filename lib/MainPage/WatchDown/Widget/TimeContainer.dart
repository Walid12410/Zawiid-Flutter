import 'package:flutter/material.dart';

class TimeContainer extends StatelessWidget {
  final String label;
  final int value;

  const TimeContainer({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          width: screenWidth * 0.10,
          height: screenHeight * 0.05,
          margin:const EdgeInsets.all(8.0),
          padding:const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset:const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '$value',
              style:  TextStyle(fontSize: screenWidth * 0.04),
            ),
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: screenWidth * 0.03 ),
        ),
      ],
    );
  }
}
