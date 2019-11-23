import 'package:simple_chess_clock/gamemode.dart';
import 'package:simple_chess_clock/playerdata.dart';

class Repository{
  GameMode currentlyEditedGameMode;

  List<GameMode> _configurations;
  List<GameMode> get getconfigurations {
    if (_configurations == null) {
      final PlayerData playerOneData =
          PlayerData('Player 1', <DurationType, TimeSpan>{ DurationType.Time: TimeSpan(0, 1, 0), DurationType.Increment: TimeSpan(0, 0, 1)});
      final PlayerData playerTwoData =
          PlayerData('Player 2', <DurationType, TimeSpan>{ DurationType.Time:TimeSpan(0, 1, 0), DurationType.Increment: TimeSpan(0, 0, 1)});

      final GameMode configuration = GameMode(
          'Blitz 1m + 1s', <PlayerData>[playerOneData, playerTwoData]);

      final PlayerData playerOneData2 =
          PlayerData('Player 1', <DurationType, TimeSpan>{ DurationType.Time: TimeSpan(0, 3, 0), DurationType.Increment: TimeSpan(0, 0, 2)});
      final PlayerData playerTwoData2 =
          PlayerData('Player 2', <DurationType, TimeSpan>{ DurationType.Time:TimeSpan(0, 3, 0), DurationType.Increment: TimeSpan(0, 0, 2)});

      final GameMode configuration2 = GameMode(
          'Blitz 3m + 2s', <PlayerData>[playerOneData2, playerTwoData2]);

      final PlayerData playerOneData3 =
          PlayerData('Player 1', <DurationType, TimeSpan>{ DurationType.Time: TimeSpan(0, 5, 0), DurationType.Increment: TimeSpan(0, 0, 0)});
      final PlayerData playerTwoData3 =
          PlayerData('Player 2', <DurationType, TimeSpan>{ DurationType.Time:TimeSpan(0, 5, 0), DurationType.Increment: TimeSpan(0, 0, 0)});

      final GameMode configuration3 = GameMode(
          'Blitz 5m', <PlayerData>[playerOneData3, playerTwoData3]);

      final PlayerData playerOneData4 =
          PlayerData('Player 1', <DurationType, TimeSpan>{ DurationType.Time: TimeSpan(0, 15, 0), DurationType.Increment: TimeSpan(0, 0, 10)});
      final PlayerData playerTwoData4 =
          PlayerData('Player 2', <DurationType, TimeSpan>{ DurationType.Time:TimeSpan(0, 15, 0), DurationType.Increment: TimeSpan(0, 0, 10)});

      final GameMode configuration4 = GameMode(
          'Rapid 15m + 10s', <PlayerData>[playerOneData4, playerTwoData4]);

      final PlayerData playerOneData5 =
          PlayerData('Player 1', <DurationType, TimeSpan>{ DurationType.Time: TimeSpan(0, 25, 0), DurationType.Increment: TimeSpan(0, 0, 10)});
      final PlayerData playerTwoData5 =
          PlayerData('Player 2', <DurationType, TimeSpan>{ DurationType.Time:TimeSpan(0, 25, 0), DurationType.Increment: TimeSpan(0, 0, 10)});

      final GameMode configuration5 = GameMode(
          'Rapid 25m + 10s', <PlayerData>[playerOneData5, playerTwoData5]);

      final PlayerData playerOneData6 =
          PlayerData('Player 1', <DurationType, TimeSpan>{ DurationType.Time: TimeSpan(0, 25, 0), DurationType.Increment: TimeSpan(0, 0, 0)});
      final PlayerData playerTwoData6 =
          PlayerData('Player 2', <DurationType, TimeSpan>{ DurationType.Time:TimeSpan(0, 25, 0), DurationType.Increment: TimeSpan(0, 0, 0)});

      final GameMode configuration6 = GameMode(
          'Rapid 25m', <PlayerData>[playerOneData6, playerTwoData6]);

      _configurations = <GameMode>[configuration, configuration2, configuration3, configuration4, configuration5, configuration6];
    }
    return _configurations;
  }
}