import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GameEvent extends Equatable {
  const GameEvent();
}

class SwitchTurnEvent extends GameEvent {
  const SwitchTurnEvent(this.playerIndex);

  final int playerIndex;

  @override
  List<Object> get props => <Object>[playerIndex];
}

class StartStopGameEvent extends GameEvent {
  const StartStopGameEvent(this.isGameRunning);
  final bool isGameRunning;

  @override
  List<Object> get props => <Object>[isGameRunning];
}

class RestartGameEvent extends GameEvent {
  @override
  List<Object> get props => null;
}

class EndGameEvent extends GameEvent {
  @override
  List<Object> get props => null;
}
