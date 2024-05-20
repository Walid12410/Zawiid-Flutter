import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpeningImage extends StatelessWidget {
  const OpeningImage({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 220.h,
        child: Image.network(
          'https://images.unsplash.com/photo-1468421201266-ec88b2809284?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          fit: BoxFit.fill,
        ));
  }
}
