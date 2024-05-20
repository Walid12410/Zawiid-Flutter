import 'package:flutter/material.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'Widget/DetailsCard.dart';

class UpComingTab extends StatefulWidget {
  const UpComingTab({super.key});

  @override
  State<UpComingTab> createState() => _UpComingTabState();
}

class _UpComingTabState extends State<UpComingTab> {
  @override
  Widget build(BuildContext context) {
    DateTime endTime = DateTime.now().add(const Duration(hours: 1, minutes: 30));

    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DetailsUpComing( endTime: endTime),
              DetailsUpComing( endTime: endTime),
              DetailsUpComing(endTime: endTime),
              DetailsUpComing(endTime: endTime),
            ],
          ),
        ),
      ),
    );
  }
}

