import 'package:flutter/material.dart';

class OpeningImage extends StatelessWidget {
  const OpeningImage({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: screenHeight * 0.30,
        child: Image.network(
          'https://images.unsplash.com/photo-1468421201266-ec88b2809284?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          fit: BoxFit.fill,
        ));
  }
}
