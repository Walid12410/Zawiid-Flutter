import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Color&Icons/color.dart';

import '../PageHeadWidget.dart';
import 'Widget/PaymentDetails.dart';

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
               PageHeadView(title: 'Payment',onPressed: (){
                 GoRouter.of(context).go("/home");
               },),
              SizedBox(height: 2.h,),
              const PaymentDetails(),
            ],
          ),
        ),
      ),
    );
  }
}


