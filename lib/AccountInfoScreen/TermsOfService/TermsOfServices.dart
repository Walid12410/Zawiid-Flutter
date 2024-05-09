import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Color&Icons/color.dart';

import 'Widget/LegalHeader.dart';
import 'Widget/LegalInfoImage.dart';


class TermsOfServices extends StatefulWidget {
  const TermsOfServices({super.key});

  @override
  State<TermsOfServices> createState() => _TermsOfServicesState();
}

class _TermsOfServicesState extends State<TermsOfServices> {
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
              LegalHeader(screenWidth: screenWidth, screenHeight: screenHeight),
              SizedBox(height: screenHeight * 0.01,),
              LegalInformationImage(screenHeight: screenHeight)
            ],
          ),
        ),
      ),
    );
  }
}


