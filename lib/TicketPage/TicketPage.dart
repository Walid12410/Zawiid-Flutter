import 'package:flutter/material.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'Widget/ShowDetails.dart';
import 'Widget/TicketBackArrow.dart';
import 'Widget/TicketDetailsBottom.dart';
import 'Widget/TicketDetailsText.dart';
import 'Widget/TicketImage.dart';
import 'Widget/TicketPriceDetails.dart';

class TicketMain extends StatefulWidget {
  const TicketMain({super.key});

  @override
  State<TicketMain> createState() => _TicketMainState();
}

class _TicketMainState extends State<TicketMain> {
  bool _showDetails = true;
  bool _showDetailsBottom = true;

  void toggleVisibility() {
    setState(() {
      _showDetails = !_showDetails;
      _showDetailsBottom = !_showDetailsBottom;
    });
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight * 0.01,
              ),
              TicketBackArrow(screenWidth: screenWidth,screenHeight: screenHeight,),

              SizedBox(
                height: screenHeight * 0.03,
              ),
              TicketImage(screenHeight: screenHeight),
              if (_showDetailsBottom)
                TicketDetailsBottom(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    onTap: toggleVisibility),
              if (_showDetails) ...[
                TicketDetailsText(screenHeight: screenHeight,screenWidth: screenWidth,),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                TicketPriceDetails(
                    screenWidth: screenWidth, screenHeight: screenHeight)
              ],
              if (!_showDetails)
                TicketDetails(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  onTap: toggleVisibility,
                )
            ],
          ),
        ),
      ),
    );
  }
}

