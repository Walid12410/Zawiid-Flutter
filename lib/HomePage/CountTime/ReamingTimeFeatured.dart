import 'package:flutter/material.dart';

import '../Widget/TimeWeekDeal.dart';


class CountTimeReamingFeatured extends StatelessWidget {
  final Duration remainingTime;

  const CountTimeReamingFeatured({super.key,required this.remainingTime});


  @override
  Widget build(BuildContext context) {
    int days = remainingTime.inDays;
    int hours = remainingTime.inHours.remainder(24);
    int minutes = remainingTime.inMinutes.remainder(60);
    int seconds = remainingTime.inSeconds.remainder(60);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TimerWeekDeal(name: 'Day', value: days),
        TimerWeekDeal(name: 'Hours', value: hours),
        TimerWeekDeal(name: 'Minutes', value: minutes),
      ],
    );
  }
}