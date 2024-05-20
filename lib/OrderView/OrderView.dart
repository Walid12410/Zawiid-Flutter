import 'package:flutter/material.dart';
import 'package:zawiid/Color&Icons/color.dart';

import 'Widget/OrderViewDetails.dart';
import 'Widget/OrderViewHeader.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              OrderViewHeader(),
              OrderViewDetails(),
              OrderViewDetails(),
              OrderViewDetails(),
              OrderViewDetails(),
              OrderViewDetails(),
            ],
          ),
        ),
      ),
    );
  }
}
