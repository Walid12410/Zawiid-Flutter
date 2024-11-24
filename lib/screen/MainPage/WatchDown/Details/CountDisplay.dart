import 'package:flutter/material.dart';
import 'package:zawiid/generated/l10n.dart';
import 'TimeContainer.dart';

class CountdownDisplay extends StatelessWidget {
  final Duration remainingTime;

  const CountdownDisplay({Key? key, required this.remainingTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int days = remainingTime.inDays;
    int hours = remainingTime.inHours.remainder(24);
    int minutes = remainingTime.inMinutes.remainder(60);
    int seconds = remainingTime.inSeconds.remainder(60);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TimeContainer(label: S.of(context).day, value: days),
        TimeContainer(label: S.of(context).hour, value: hours),
        TimeContainer(label: S.of(context).minutes, value: minutes),
        TimeContainer(label: S.of(context).second, value: seconds),
      ],
    );
  }
}
