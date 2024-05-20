import 'package:flutter/material.dart';
import 'package:zawiid/Color&Icons/color.dart';

import 'Widget/SoldDetail.dart';

class EndedTab extends StatefulWidget {
  const EndedTab({super.key});

  @override
  State<EndedTab> createState() => _EndedTabState();
}

class _EndedTabState extends State<EndedTab> {

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SoldDetails(),
              SoldDetails(),
              SoldDetails(),
              SoldDetails(),
            ],
          ),
        ),
      ),
    );
  }
}

