import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:simple_chess_clock/playerdata.dart';

@immutable
abstract class DurationPickerEvent extends Equatable {
  const DurationPickerEvent();
}

class TimeSpanChangedEvent extends DurationPickerEvent{
  const TimeSpanChangedEvent(this.newTimeSpan);
  final TimeSpan newTimeSpan;

  @override
  List<Object> get props => <Object>[newTimeSpan];
}