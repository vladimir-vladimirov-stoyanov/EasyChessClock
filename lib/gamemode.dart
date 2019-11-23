
import 'package:equatable/equatable.dart';
import 'package:simple_chess_clock/playerdata.dart';

class GameMode implements Equatable{
  GameMode(this.name, this.playerConfigurations) : super();

  GameMode.empty() : name = 'My game mode', 
      playerConfigurations = createEmptyConfigurations();

  GameMode copyGameMode(){
    final List<PlayerData> copiedPlayerConfigurations = <PlayerData>[];
    for (int i = 0; i < playerConfigurations.length; i++) {
      copiedPlayerConfigurations.add(playerConfigurations[i].copy());
    }
    return GameMode(name, copiedPlayerConfigurations);
  }

  final List<PlayerData> playerConfigurations;
  String name;

  bool sameSettingsForBothPlayers = true;

  @override
  List<dynamic> get props => <dynamic>[name, playerConfigurations, sameSettingsForBothPlayers];

  static List<PlayerData> createEmptyConfigurations() {
    final PlayerData playerOneData =
          PlayerData('Player 1', <DurationType, TimeSpan>{ DurationType.Time: TimeSpan.empty(), DurationType.Increment: TimeSpan.empty()});
      final PlayerData playerTwoData =
          PlayerData('Player 2', <DurationType, TimeSpan>{ DurationType.Time:TimeSpan.empty(), DurationType.Increment: TimeSpan.empty()});

      return <PlayerData>[playerOneData, playerTwoData];
  }

}