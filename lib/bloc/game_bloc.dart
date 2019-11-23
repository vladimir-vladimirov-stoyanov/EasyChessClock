import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:simple_chess_clock/dependencies.dart';
import 'package:simple_chess_clock/gamemode.dart';
import 'package:simple_chess_clock/playerdata.dart';
import './bloc.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc(this.gameMode);
  GameMode gameMode;
  List<Dependencies> timerDependencies = <Dependencies>[
    Dependencies(),
    Dependencies()
  ];
  int currentPlayerIndex = 0;
  bool isGameRunning = false;

  int get otherPlayerIndex {
    return currentPlayerIndex == 0 ? 1 : 0;
  }

  @override
  GameState get initialState => const InitialGameState(false);

  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    if (event is SwitchTurnEvent) {
      if (currentPlayerIndex == event.playerIndex && isGameRunning) {
        gameMode.playerConfigurations[event.playerIndex]
            .durations[DurationType.Time]
            .addToTimeSpan(gameMode.playerConfigurations[event.playerIndex]
                .durations[DurationType.Increment]);
        final Duration incrementedTime = gameMode
            .playerConfigurations[event.playerIndex]
            .durations[DurationType.Time]
            .getDuration();
        timerDependencies[currentPlayerIndex].stopwatch.stop();
        timerDependencies[otherPlayerIndex].stopwatch.start();
        currentPlayerIndex = otherPlayerIndex;
        yield SwitchTurnState(incrementedTime, currentPlayerIndex);
      }
    } else if (event is StartStopGameEvent) {
      isGameRunning = event.isGameRunning;
      if (isGameRunning) {
        timerDependencies[currentPlayerIndex].stopwatch.start();
      } else {
        timerDependencies[currentPlayerIndex].stopwatch.stop();
        timerDependencies[otherPlayerIndex].stopwatch.stop();
      }

      yield InitialGameState(isGameRunning);
    } else if (event is EndGameEvent) {
      isGameRunning = false;
      timerDependencies[currentPlayerIndex].stopwatch.stop();
      yield EndGameState();
    } else if (event is RestartGameEvent) {
      currentPlayerIndex = 0;
      timerDependencies[0].stopwatch.reset();
      timerDependencies[1].stopwatch.reset();

      yield const InitialGameState(false);
    }
  }
}
