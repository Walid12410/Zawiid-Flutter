import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/Color&Icons/color.dart';

import 'Widget/PaymentDetails.dart';
import 'Widget/PaymentHead.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const PaymentHead(),
              SizedBox(height: 2.h,),
              const PaymentDetails(),
            ],
          ),
        ),
      ),
    );
  }
}


