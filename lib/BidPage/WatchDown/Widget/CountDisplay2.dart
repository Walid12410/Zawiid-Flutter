import 'package:flutter/material.dart';
import 'package:zawiid/generated/l10n.dart';
import 'TimeContainer2.dart';

class CountdownDisplay2 extends StatelessWidget {
  final Duration remainingTime;

  const CountdownDisplay2({Key? key, required this.remainingTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int days = remainingTime.inDays;
    int hours = remainingTime.inHours.remainder(24);
    int minutes = remainingTime.inMinutes.remainder(60);
    int seconds = remainingTime.inSeconds.remainder(60);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TimeContainer2(label: S.of(context).day, value: days),
        TimeContainer2(label: S.of(context).hour, value: hours),
        TimeContainer2(label: S.of(context).minutes, value: minutes),
        TimeContainer2(label: S.of(context).second, value: seconds),
      ],
    );
  }
}
