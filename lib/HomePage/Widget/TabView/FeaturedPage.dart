import 'package:flutter/material.dart';
import '../TabCard.dart';


class FeaturedPageView extends StatelessWidget {
  const FeaturedPageView({Key? key})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    final List<String> names = [
      'SAMSUNG Galaxy S24 Ultra, 128GB RAM +...',
      'Iphone 16 Pro Max, 159GB RAM SADASDASDASD',
      'SAMSUNG Galaxy S24 Ultra, 128GB RAM +...',
      'SAMSUNG Galaxy S24 Ultra, 128GB RAM +...',
    ];

    return Column(
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
    );
  }
}
