import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DurationPartBlocEvent extends Equatable {
  const DurationPartBlocEvent();
}

class DurationPartChangedEvent extends DurationPartBlocEvent{
  const DurationPartChangedEvent(this.value);
  final int value;
  @override
  List<Object> get props => <Object>[value];
}
