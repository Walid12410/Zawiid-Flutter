import 'package:flutter/material.dart';

import '../Widget/TabCard.dart';

class OnSalePageView extends StatelessWidget {
  const OnSalePageView({super.key,required this.scrollController});
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final List<String> names = [
      'SAMSUNG Galaxy S24 Ultra, 128GB RAM +...',
      'Iphone 16 Pro Max, 159GB RAM SADASDASDASD',
      'SAMSUNG Galaxy S24 Ultra, 128GB RAM +...',
      'SAMSUNG Galaxy S24 Ultra, 128GB RAM +...',
    ];

    return Scaffold(
        body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TabCard(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      names: names),
                  TabCard(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      names: names),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TabCard(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      names: names),
                  TabCard(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      names: names),
                ],
              ),
            ],
          ),
        ));
  }
}
