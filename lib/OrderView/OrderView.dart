import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Color&Icons/color.dart';

import 'Widget/OrderViewDetails.dart';
import 'Widget/OrderViewHeader.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
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
              OrderViewHeader(
                  screenWidth: screenWidth, screenHeight: screenHeight),
              OrderViewDetails(
                  screenWidth: screenWidth, screenHeight: screenHeight),
              OrderViewDetails(
                  screenWidth: screenWidth, screenHeight: screenHeight),
              OrderViewDetails(
                  screenWidth: screenWidth, screenHeight: screenHeight),
              OrderViewDetails(
                  screenWidth: screenWidth, screenHeight: screenHeight),
              OrderViewDetails(
                  screenWidth: screenWidth, screenHeight: screenHeight),

            ],
          ),
        ),
      ),
    );
  }
}
