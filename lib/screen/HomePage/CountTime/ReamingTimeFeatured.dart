import 'package:flutter/material.dart';
import 'package:zawiid/generated/l10n.dart';
import '../Details/TimeWeekDeal.dart';


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
        TimerWeekDeal(name: S.of(context).day, value: days),
        TimerWeekDeal(name: S.of(context).hour, value: hours),
        TimerWeekDeal(name: S.of(context).minutes, value: minutes),
      ],
    );
  }
}