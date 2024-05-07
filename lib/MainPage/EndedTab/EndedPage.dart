import 'package:flutter/material.dart';
import 'package:zawiid/Color&Icons/color.dart';

import 'Widget/SoldDetail.dart';

class EndedTab extends StatefulWidget {
  const EndedTab({super.key});

  @override
  State<EndedTab> createState() => _EndedTabState();
}

class _EndedTabState extends State<EndedTab> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SoldDetails(screenHeight: screenHeight, screenWidth: screenWidth),
              SoldDetails(screenHeight: screenHeight, screenWidth: screenWidth),
              SoldDetails(screenHeight: screenHeight, screenWidth: screenWidth),
              SoldDetails(screenHeight: screenHeight, screenWidth: screenWidth),
            ],
          ),
        ),
      ),
    );
  }
}

