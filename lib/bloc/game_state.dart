import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GameState extends Equatable {
  const GameState();
}

class InitialGameState extends GameState {
  const InitialGameState(this.isGameRunning);

  final bool isGameRunning;

  @override
  List<Object> get props => <Object>[isGameRunning];
}

class SwitchTurnState extends GameState {
  const SwitchTurnState(this.timeDuration, this.currentPlayerIndex);
  final Duration timeDuration;
  final int currentPlayerIndex;

  @override
  List<Object> get props => <Object>[timeDuration, currentPlayerIndex];
}

class EndGameState extends GameState {
  @override
  List<Object> get props => null;
}
