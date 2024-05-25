import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/Color&Icons/color.dart';

import 'Widget/BidPageDetails.dart';
import 'Widget/BidPageHead.dart';
import 'Widget/BidPageImage.dart';

class BidPage extends StatefulWidget {
  const BidPage({super.key});

  @override
  State<BidPage> createState() => _BidPageState();
}

class _BidPageState extends State<BidPage> {
  DateTime endTime = DateTime.now().add(const Duration(hours: 1, minutes: 30));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0).w,
            child: Column(
              children: [
                SizedBox(height: 5.h),
                const BidPageHead(),
                const BidPageImage(),
                BidPageDetails(endTime: endTime),
                SizedBox(height: 20.h,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}




