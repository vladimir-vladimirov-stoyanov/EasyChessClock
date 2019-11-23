import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chess_clock/bloc/bloc.dart';
import 'package:simple_chess_clock/playerdata.dart';

import 'package:simple_chess_clock/sizeConfig.dart';
import 'package:simple_chess_clock/timertext.dart';

class PlayerSide extends StatefulWidget {
  const PlayerSide(this.playerIndex);

  final int playerIndex;

  @override
  _PlayerSideState createState() => _PlayerSideState();
}

class _PlayerSideState extends State<PlayerSide> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.safeBlockVertical * 45,
      child: BlocBuilder<GameBloc, GameState>(
          builder: (BuildContext context, GameState state) {
        return buildTimerTextButton(context, state);
      }),
    );
  }

  FlatButton buildTimerTextButton(BuildContext context, GameState state) {
    Duration timeDuration;
    final bool isOnTurn = widget.playerIndex == BlocProvider.of<GameBloc>(context).currentPlayerIndex;
    bool isGameOver = false;
    if (state is SwitchTurnState && state.currentPlayerIndex != widget.playerIndex) {
      timeDuration = state.timeDuration;
    } else if (state is EndGameState) {
      isGameOver = isOnTurn;
      timeDuration = BlocProvider.of<GameBloc>(context)
          .gameMode
          .playerConfigurations[widget.playerIndex]
          .durations[DurationType.Time]
          .getDuration();
    }
    else {
      timeDuration = BlocProvider.of<GameBloc>(context)
          .gameMode
          .playerConfigurations[widget.playerIndex]
          .durations[DurationType.Time]
          .getDuration();
    } 
    return FlatButton(
        color: isGameOver ? Colors.redAccent : isOnTurn ? Theme.of(context).accentColor : Theme.of(context).secondaryHeaderColor,
        child: TimerText(
          dependencies: BlocProvider.of<GameBloc>(context)
              .timerDependencies[widget.playerIndex],
          duration: timeDuration,
        ),
        onPressed: () {
          BlocProvider.of<GameBloc>(context)
              .add(SwitchTurnEvent(widget.playerIndex));
        });
  }
}
