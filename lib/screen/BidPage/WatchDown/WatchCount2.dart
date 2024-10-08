import 'dart:async';
import 'package:flutter/material.dart';

import 'Details/CountDisplay2.dart';

class CountdownTimerScreen2 extends StatefulWidget {
  final DateTime endTime;

  const CountdownTimerScreen2({Key? key, required this.endTime}) : super(key: key);

  @override
  _CountdownTimerScreen2State createState() => _CountdownTimerScreen2State();
}

class _CountdownTimerScreen2State extends State<CountdownTimerScreen2> {
  late Timer _timer;
  late DateTime _endTime;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _endTime = widget.endTime;
    _timer = Timer.periodic( const Duration(seconds: 1), _updateTimer);
  }

  void _updateTimer(Timer timer) {
    final now = DateTime.now();
    if (now.isBefore(_endTime)) {
      setState(() {
        _remainingTime = _endTime.difference(now);
      });
    } else {
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
    return CountdownDisplay2(remainingTime: _remainingTime);
  }
}


