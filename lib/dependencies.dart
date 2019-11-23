import 'package:flutter/material.dart';

class Dependencies {
  final List<ValueChanged<ElapsedTime>> timerListeners = <ValueChanged<ElapsedTime>>[];
  final TextStyle textStyle = const TextStyle(fontSize: 90.0, fontFamily: 'Bebas Neue');
  final Stopwatch stopwatch = Stopwatch();
  final int timerMillisecondsRefreshRate = 30;
}

class ElapsedTime {
  const ElapsedTime({
    this.hundreds,
    this.seconds,
    this.minutes,
    this.hours,
  });

  final int hundreds;
  final int seconds;
  final int minutes;
  final int hours;
}