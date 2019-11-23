import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:simple_chess_clock/playerdata.dart';

@immutable
class TimeSpanChanged extends Equatable {
  const TimeSpanChanged(this.timeSpan);

  final TimeSpan timeSpan;

  @override
  List<Object> get props => <Object>[timeSpan];
}
