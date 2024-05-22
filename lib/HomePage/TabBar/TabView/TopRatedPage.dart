import 'package:flutter/material.dart';
import 'package:zawiid/Color&Icons/color.dart';

import '../Widget/TabCard.dart';

class TopRatedPageView extends StatelessWidget {
  const TopRatedPageView({super.key,required this.scrollController});
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {


    final List<String> names = [
      'SAMSUNG Galaxy S24 Ultra, 128GB RAM +...',
      'Iphone 16 Pro Max, 159GB RAM SADASDASDASD',
      'SAMSUNG Galaxy S24 Ultra, 128GB RAM +...',
      'SAMSUNG Galaxy S24 Ultra, 128GB RAM +...',
    ];

    return Scaffold(
      backgroundColor: tdWhite,
        body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TabCard(names: names),
                  TabCard(names: names),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TabCard(names: names),
                  TabCard(names: names),
                ],
              ),
            ],
          ),
        ));
  }
}
