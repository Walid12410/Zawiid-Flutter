import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimerScreen extends StatefulWidget {
  final DateTime endTime;

  const CountdownTimerScreen({Key? key, required this.endTime}) : super(key: key);

  @override
  _CountdownTimerScreenState createState() => _CountdownTimerScreenState();
}

class _CountdownTimerScreenState extends State<CountdownTimerScreen> {
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
      // If you want to do something when the timer finishes, you can add it here
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CountdownDisplay(remainingTime: _remainingTime);
  }
}

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
        TimeContainer(label: 'Days', value: days),
        TimeContainer(label: 'Hours', value: hours),
        TimeContainer(label: 'Minutes', value: minutes),
        TimeContainer(label: 'Seconds', value: seconds),
      ],
    );
  }
}

class TimeContainer extends StatelessWidget {
  final String label;
  final int value;

  const TimeContainer({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          width: screenWidth * 0.10,
          height: screenHeight * 0.05,
          margin:const EdgeInsets.all(8.0),
          padding:const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset:const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '$value',
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 10),
        ),
      ],
    );
  }
}
