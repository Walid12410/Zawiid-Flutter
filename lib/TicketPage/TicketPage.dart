import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              const TicketBackArrow(),
              const TicketImage(),
              if (_showDetailsBottom)
                TicketDetailsBottom(onTap: toggleVisibility),
              _showDetailsBottom || _showDetails ? Container() : SizedBox(
                height: 25.h,
              ),
              if (_showDetails) ...[
                SizedBox(
                  height: 10.h,
                ),
                const TicketDetailsText(),
                SizedBox(
                  height: 15.h,
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

