import 'dart:async';

import 'package:flutter/material.dart';

import 'ReamingTimeFeatured.dart';


class CountTimerFeatured extends StatefulWidget {
  final DateTime startTime;
  final DateTime endTime;

  const CountTimerFeatured({Key? key, required this.startTime, required this.endTime}) : super(key: key);

  @override
  State<CountTimerFeatured> createState() => _CountTimerFeaturedState();
}

class _CountTimerFeaturedState extends State<CountTimerFeatured> {
  late Timer _timer;
  late DateTime _startTime;
  late DateTime _endTime;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startTime = widget.startTime;
    _endTime = widget.endTime;
    _calculateRemainingTime(); // Calculate remaining time immediately
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
  }

  void _updateTimer(Timer timer) {
    _calculateRemainingTime();
  }

  void _calculateRemainingTime() {
    final now = DateTime.now();
    if (now.isBefore(_endTime)) {
      setState(() {
        _remainingTime = _endTime.difference(now);
      });
    } else {
      setState(() {
        _remainingTime = Duration.zero;
      });
      _timer.cancel();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CountTimeReamingFeatured(remainingTime: _remainingTime);
  }
}
