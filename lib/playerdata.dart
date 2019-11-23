import 'package:equatable/equatable.dart';

class PlayerData{
  PlayerData(this.name, this.durations);

  PlayerData copy() {
    final Map<DurationType, TimeSpan> copiedDurations =  <DurationType, TimeSpan>{};
    copiedDurations[DurationType.Time] = durations[DurationType.Time].copy();
    copiedDurations[DurationType.Increment] = durations[DurationType.Increment].copy();

    return PlayerData(name, copiedDurations);
  }

  final String name;
  final Map<DurationType, TimeSpan> durations;
}

class TimeSpan extends Equatable{
  TimeSpan(this.hours, this.minutes, this.seconds);

  TimeSpan.empty() : hours = 0, minutes = 0, seconds = 0;

  TimeSpan copy(){
    return TimeSpan(hours, minutes, seconds);
  }

  

  int hours;
  int minutes;
  int seconds;

  int operator [](int index) {
    switch (index) {
      case 0:
        return hours;
        break;
      case 1:
        return minutes;
        break;
      case 2:
        return seconds;
        break;
      default: 
        assert(index < 0 || index > 2, 'TimeSpan indexer should be called with 0, 1 or 2');
        return 0;
    }
  }
    
  @override
  List<Object> get props => <Object>[hours, minutes, seconds];
  

  void addToTimeSpan(TimeSpan timeSpanToAdd){
    hours += timeSpanToAdd.hours;
    minutes += timeSpanToAdd.minutes;
    seconds += timeSpanToAdd.seconds;

  }

  Duration getDuration(){
    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }
}

enum DurationType { 
   Time, 
   Increment, 
}