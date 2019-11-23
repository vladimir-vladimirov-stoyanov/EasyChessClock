import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chess_clock/bloc/bloc.dart';
import 'package:simple_chess_clock/dependencies.dart';

class TimerText extends StatefulWidget {
  const TimerText({this.dependencies, this.duration});
  final Dependencies dependencies;
  final Duration duration;

  @override
  TimerTextState createState() => TimerTextState(dependencies: dependencies);
}

class TimerTextState extends State<TimerText> {
  TimerTextState({this.dependencies});
  final Dependencies dependencies;
  Timer timer;
  int milliseconds;

  @override
  void initState() {
    timer = Timer.periodic(
        Duration(milliseconds: dependencies.timerMillisecondsRefreshRate),
        callback);
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  void callback(Timer timer) {
    if (milliseconds != dependencies.stopwatch.elapsedMilliseconds) {
      milliseconds = widget.duration.inMilliseconds -
          dependencies.stopwatch.elapsedMilliseconds;
      final int hundreds = (milliseconds / 10).truncate();
      final int seconds = (hundreds / 100).truncate();
      final int minutes = (seconds / 60).truncate();
      final int hours = (minutes / 60).truncate();
      ElapsedTime elapsedTime = ElapsedTime(
        hundreds: hundreds,
        seconds: seconds,
        minutes: minutes,
        hours: hours,
      );

      if (hundreds <= 0) {
        BlocProvider.of<GameBloc>(context).add(EndGameEvent());
        elapsedTime = const ElapsedTime(
          hundreds: 0,
          seconds: 0,
          minutes: 0,
          hours: 0,
        );
      }

      for (Function(ElapsedTime) listener in dependencies.timerListeners) {
        listener(elapsedTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RepaintBoundary(
          child: HoursMinutesAndSeconds(dependencies: dependencies),
        ),
        RepaintBoundary(
          child: Hundreds(dependencies: dependencies),
        ),
      ],
    );
  }
}

class HoursMinutesAndSeconds extends StatefulWidget {
  const HoursMinutesAndSeconds({this.dependencies});
  final Dependencies dependencies;

  @override
  HoursMinutesAndSecondsState createState() =>
      HoursMinutesAndSecondsState(dependencies: dependencies);
}

class HoursMinutesAndSecondsState extends State<HoursMinutesAndSeconds> {
  HoursMinutesAndSecondsState({this.dependencies});
  final Dependencies dependencies;

  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  @override
  void initState() {
    dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.hours != hours ||
        elapsed.minutes != minutes ||
        elapsed.seconds != seconds) {
      setState(() {
        hours = elapsed.hours;
        minutes = elapsed.minutes;
        seconds = elapsed.seconds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String hoursStr = (hours % 60).toString().padLeft(2, '0');
    final String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    final String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    String timeLeftStr;
    if (hours == 0) {
      timeLeftStr = '$minutesStr:$secondsStr.';
    } else {
      timeLeftStr = '$hoursStr:$minutesStr:$secondsStr.';
    }

    return Center(
      child: Text(
        timeLeftStr,
        style: dependencies.textStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class Hundreds extends StatefulWidget {
  const Hundreds({this.dependencies});
  final Dependencies dependencies;

  @override
  HundredsState createState() => HundredsState(dependencies: dependencies);
}

class HundredsState extends State<Hundreds> {
  HundredsState({this.dependencies});
  final Dependencies dependencies;

  int hundreds = 0;

  @override
  void initState() {
    dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.hundreds != hundreds) {
      setState(() {
        hundreds = elapsed.hundreds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');
    return Center(child: Text(hundredsStr, style: dependencies.textStyle));
  }
}
